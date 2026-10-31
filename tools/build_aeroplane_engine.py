"""飞行棋固定路径与纯规则计划器。位置 -1 机场、0 起飞、1..51 外环、52..57 内道。"""
from pathlib import Path
import json

PACK = Path(__file__).resolve().parents[1]
ROOT = PACK / 'data/aeroplane_chess/function'
# 传统17单位棋盘，统一映射到现有15格坐标系；逻辑路径编号不变。
BASE_RING_U = [(6.5,16),(16/3,47/3),(5,14.5),(5,13.5),(16/3,37/3),
               (14/3,35/3),(3.5,12),(2.5,12),(4/3,35/3),(1,10.5),
               (1,9.5),(1,8.5),(1,7.5)]


def rectangle(x0,z0,x1,z1):
    return [(x0,z0),(x1,z0),(x1,z1),(x0,z1)]


BASE_RING_CELLS_U = [
    rectangle(6,15,7,17),[(4,15),(6,15),(6,17)],
    rectangle(4,14,6,15),rectangle(4,13,6,14),
    [(6,11),(6,13),(4,13)],[(4,11),(6,11),(4,13)],
    rectangle(3,11,4,13),rectangle(2,11,3,13),
    [(0,11),(2,11),(2,13)],rectangle(0,10,2,11),
    rectangle(0,9,2,10),rectangle(0,8,2,9),rectangle(0,7,2,8),
]


def grid_point(point):
    return [round(value*.8+.2,8) for value in point]

def rotate(point, color):
    x,z = point
    for _ in range(color): x,z = 14-z,x
    return [round(x,8),round(z,8)]


RING = [rotate(grid_point(point),color) for color in range(4) for point in BASE_RING_U]

def path_manifest():
    def point(value,color):return rotate(grid_point(value),color)
    def polygon(values,color):return [point(value,color) for value in values]
    return {'grid':15,'unit_step':.8,'design':'traditional_17','design_units':17,'center':[7,7],
            'ring':RING,'ring_cells':[polygon(cell,color) for color in range(4) for cell in BASE_RING_CELLS_U],
            'positions':{'hangar':-1,'launch':0,'outer':[1,51],'home':[52,57],'finished':57},
            'colors':[{'id':c,'name':n,'start':c*13,'launch':point((6.5,17.25),c),
                       'home':[point((8.5,14.5-i),c) for i in range(6)],
                       'hangar':[point(p,c) for p in [(1.05,14.05),(2.95,14.05),(1.05,15.95),(2.95,15.95)]],
                       'airport':polygon(rectangle(0,13,4,17),c),
                       'home_cells':[polygon(rectangle(8,14-i,9,15-i),c) for i in range(5)],
                       'terminal':polygon([(7.15,10),(9.85,10),(8.5,8.65)],c)
                       } for c,n in enumerate(['red','blue','green','yellow'])],
            'jump_positions':list(range(3,48,4)),'flight':{'from':19,'to':31},'priority':'fly then jump, each at most once'}

def reference_plan(pos,dice,takeoff=0,jump=1,fly=1,finish=0):
    if not -1 <= pos < 57 or not 1 <= dice <= 6: return []
    if pos == -1:
        return [{'pos':0,'kind':1,'land':1}] if takeoff==2 or dice==6 or takeoff==1 and dice==5 else []
    if finish==1 and pos+dice>57:return []
    queue=[];direction=1
    for _ in range(dice):
        if pos==57:direction=-1
        pos+=direction;queue.append({'pos':pos,'kind':0,'land':0})
    queue[-1]['land']=1
    usedjump=usedfly=False
    for _ in range(2):
        if fly and not usedfly and pos==19:
            pos=31;usedfly=True;queue.append({'pos':pos,'kind':3,'land':1})
        elif jump and not usedjump and pos in range(3,48,4):
            pos+=4;usedjump=True;queue.append({'pos':pos,'kind':2,'land':1})
        else:break
    return queue

def build(root=ROOT):
    def put(name,lines):
        p=root/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
        p.write_text(('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n',encoding='utf-8')
    (PACK/'tools/aeroplane_path.json').write_text(json.dumps(path_manifest(),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    put('engine/init_board',['function aeroplane_chess:system/context','kill @e[tag=ac.board]','kill @e[tag=ac.sides]']+
        [f'execute summon minecraft:marker run function aeroplane_chess:engine/side {{color:{c}}}' for c in range(4)]+
        [f'execute summon minecraft:marker run function aeroplane_chess:engine/plane {{color:{c},plane:{p}}}' for c in range(4) for p in range(4)]+
        ['function aeroplane_chess:system/context'])
    put('engine/side','''
tag @s add ac.side
scoreboard players operation @s ct_id = #table ac_ctx
$scoreboard players set @s ac_color $(color)
scoreboard players set @s ac_active 1
scoreboard players set @s ac_bot 0
scoreboard players set @s ac_rank 0
''')
    put('engine/plane','''
tag @s add ac.plane
scoreboard players operation @s ct_id = #table ac_ctx
$scoreboard players set @s ac_color $(color)
$scoreboard players set @s ac_plane $(plane)
scoreboard players set @s ac_pos -1
scoreboard players set @s ac_prev -1
scoreboard players set @s ac_legal 0
scoreboard players set @s ac_active 1
''')
    put('engine/plan','''
# 纯计划器：#plane/#color 输入，唯一骰子读取控制器；不会修改真实棋面或骰值。
scoreboard players set #legal ac_ctx 0
scoreboard players set #pos ac_ctx 99
data modify storage aeroplane_chess:runtime plan set value {queue:[]}
execute as @e[tag=ac.board] if score @s ac_plane = #plane ac_ctx if score @s ac_color = #color ac_ctx run scoreboard players operation #pos ac_ctx = @s ac_pos
execute unless score #pos ac_ctx matches -1..56 run return 0
scoreboard players operation #dice ac_ctx = @s ac_roll
execute unless score #dice ac_ctx matches 1..6 run return 0
execute if score #pos ac_ctx matches -1 run return run function aeroplane_chess:engine/takeoff
scoreboard players operation #end ac_ctx = #pos ac_ctx
scoreboard players operation #end ac_ctx += #dice ac_ctx
execute if score @s ac_finish matches 1 if score #end ac_ctx matches 58.. run return 0
scoreboard players set #direction ac_ctx 1
scoreboard players set #usedjump ac_ctx 0
scoreboard players set #usedfly ac_ctx 0
function aeroplane_chess:engine/steps
data modify storage aeroplane_chess:runtime plan.queue[-1].land set value 1
function aeroplane_chess:engine/special
function aeroplane_chess:engine/special
scoreboard players set #legal ac_ctx 1
scoreboard players operation #dest ac_ctx = #pos ac_ctx
''')
    put('engine/takeoff','''
scoreboard players set #allowed ac_ctx 0
execute if score #dice ac_ctx matches 6 run scoreboard players set #allowed ac_ctx 1
execute if score @s ac_takeoff matches 1 if score #dice ac_ctx matches 5 run scoreboard players set #allowed ac_ctx 1
execute if score @s ac_takeoff matches 2 run scoreboard players set #allowed ac_ctx 1
execute unless score #allowed ac_ctx matches 1 run return 0
data modify storage aeroplane_chess:runtime plan.queue set value [{pos:0,kind:1,land:1}]
scoreboard players set #dest ac_ctx 0
scoreboard players set #legal ac_ctx 1
''')
    put('engine/steps','''
execute if score #pos ac_ctx matches 57 run scoreboard players set #direction ac_ctx -1
scoreboard players operation #pos ac_ctx += #direction ac_ctx
data modify storage aeroplane_chess:runtime step set value {pos:0,kind:0,land:0}
execute store result storage aeroplane_chess:runtime step.pos int 1 run scoreboard players get #pos ac_ctx
data modify storage aeroplane_chess:runtime plan.queue append from storage aeroplane_chess:runtime step
scoreboard players remove #dice ac_ctx 1
execute if score #dice ac_ctx matches 1.. run function aeroplane_chess:engine/steps
''')
    put('engine/special', ['execute if score @s ac_fly matches 1 if score #usedfly ac_ctx matches 0 if score #pos ac_ctx matches 19 run return run function aeroplane_chess:engine/fly']+
        [f'execute if score @s ac_jump matches 1 if score #usedjump ac_ctx matches 0 if score #pos ac_ctx matches {p} run return run function aeroplane_chess:engine/jump' for p in range(3,48,4)])
    put('engine/fly','''
scoreboard players set #usedfly ac_ctx 1
scoreboard players set #pos ac_ctx 31
data modify storage aeroplane_chess:runtime plan.queue append value {pos:31,kind:3,land:1}
''')
    put('engine/jump','''
scoreboard players set #usedjump ac_ctx 1
scoreboard players add #pos ac_ctx 4
data modify storage aeroplane_chess:runtime step set value {pos:0,kind:2,land:1}
execute store result storage aeroplane_chess:runtime step.pos int 1 run scoreboard players get #pos ac_ctx
data modify storage aeroplane_chess:runtime plan.queue append from storage aeroplane_chess:runtime step
''')
    put('engine/legal_planes','''
function aeroplane_chess:system/context
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players set @e[tag=ac.board] ac_legal 0
scoreboard players set #available ac_ctx 0
function aeroplane_chess:engine/legal_one {plane:0}
function aeroplane_chess:engine/legal_one {plane:1}
function aeroplane_chess:engine/legal_one {plane:2}
function aeroplane_chess:engine/legal_one {plane:3}
function aeroplane_chess:visual/select
''')
    put('engine/legal_one','''
$scoreboard players set #plane ac_ctx $(plane)
function aeroplane_chess:engine/plan
execute unless score #legal ac_ctx matches 1 run return 0
scoreboard players add #available ac_ctx 1
$execute as @e[tag=ac.board,scores={ac_plane=$(plane)}] if score @s ac_color = #color ac_ctx run scoreboard players set @s ac_legal 1
''')
    put('engine/land','''
# 仅 land=1 的实际落点撞机，途经格绝不撞机；同格全部敌机一起返航。
function aeroplane_chess:system/context
execute unless score @s ac_topos matches 1..51 run return 0
scoreboard players operation #landing ac_ctx = @s ac_turn
scoreboard players operation #landing ac_ctx *= #thirteen ac_ctx
scoreboard players operation #landing ac_ctx += @s ac_topos
scoreboard players remove #landing ac_ctx 1
scoreboard players operation #landing ac_ctx %= #fiftytwo ac_ctx
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players set #captured ac_ctx 0
execute as @e[tag=ac.board,scores={ac_pos=1..51}] unless score @s ac_color = #color ac_ctx run function aeroplane_chess:engine/check_capture
execute if score #captured ac_ctx matches 1.. run function aeroplane_chess:visual/capture
execute if score #captured ac_ctx matches 1.. run function aeroplane_chess:sound/capture
''')
    put('engine/check_capture','''
scoreboard players operation #enemy ac_ctx = @s ac_color
scoreboard players operation #enemy ac_ctx *= #thirteen ac_ctx
scoreboard players operation #enemy ac_ctx += @s ac_pos
scoreboard players remove #enemy ac_ctx 1
scoreboard players operation #enemy ac_ctx %= #fiftytwo ac_ctx
execute unless score #enemy ac_ctx = #landing ac_ctx run return 0
scoreboard players operation @s ac_prev = @s ac_pos
scoreboard players set @s ac_pos -1
scoreboard players add #captured ac_ctx 1
tag @s add ac.captured
''')

if __name__=='__main__':build()
