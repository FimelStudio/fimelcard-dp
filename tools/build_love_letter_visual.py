"""生成各桌独立的情书公开展示，以及持续多个游戏刻的短动画。"""
import json
import math
from boardgame_assets import PACK, text_file

ROOT=PACK/'data/love_letter/function/visual'
ROLES=('spy','guard','priest','baron','handmaid','prince','chancellor','king','countess','princess')
SEATS={4:[(0,-.88,0),(.88,0,-90),(0,.88,180),(-.88,0,90)],
       8:[(-.75,-1.30,0),(.75,-1.30,0),(1.30,-.75,-90),(1.30,.75,-90),
          (.75,1.30,180),(-.75,1.30,180),(-1.30,.75,90),(-1.30,-.75,90)]}
SCALE=.44


def put(name,body):
    text_file(ROOT/(name+'.mcfunction'),'\n'.join(body) if isinstance(body,list) else body)


def j(value):
    return json.dumps(value,ensure_ascii=False,separators=(',',':'))


def turn(x,z,yaw):
    a=math.radians(yaw)
    return x*math.cos(a)+z*math.sin(a),-x*math.sin(a)+z*math.cos(a)


def trajectory(start,end,count=10,arc=.15):
    values=[]
    for step in range(count+1):
        t=step/count;s=t*t*(3-2*t)
        values.append([round(start[0]+(end[0]-start[0])*s,7),
                       round(start[1]+(end[1]-start[1])*s+4*t*(1-t)*arc,7),
                       round(start[2]+(end[2]-start[2])*s,7)])
    return values


def build():
    load=['scoreboard objectives add ll_v_point dummy','scoreboard objectives add ll_v_seat dummy',
          'scoreboard objectives add ll_v_kind dummy','scoreboard objectives add ll_v_age dummy']
    for capacity,seats in SEATS.items():
        values=[]
        for index,(x,z,yaw) in enumerate(seats,1):
            compx,compz=turn(SCALE/16,-SCALE/16,yaw)
            qx=math.sqrt(.5)*math.cos(math.radians(yaw)/2)
            qy=math.sqrt(.5)*math.sin(math.radians(yaw)/2)
            qz=-math.sqrt(.5)*math.sin(math.radians(yaw)/2)
            qw=math.sqrt(.5)*math.cos(math.radians(yaw)/2)
            fx,fz=turn(-.36,0,yaw)
            values.append({'x':x,'z':z,'qx':round(qx,8),'qy':round(qy,8),'qz':round(qz,8),'qw':round(qw,8),
                           'tx':round(compx,7),'tz':round(compz,7),'favor_x':round(x+fx,7),'favor_z':round(z+fz,7),
                           'count':0,'points':0,'seat':index})
        load.append(f'data modify storage love_letter:layout c{capacity}.seats set value '+j(values))
        for index,seat in enumerate(values,1):
            end=[seat['x']+seat['tx'],.022,seat['z']+seat['tz']]
            start=[seat['x']*1.14+seat['tx'],.48,seat['z']*1.14+seat['tz']]
            load.append(f'data modify storage love_letter:layout c{capacity}.play.s{index} set value '+j(trajectory(start,end,8,.05)))
            load.append(f'data modify storage love_letter:layout c{capacity}.token.s{index} set value '+
                        j(trajectory([0,.48,0],[seat['favor_x'],.10,seat['favor_z']],12,.28)))
            for other,target in enumerate(values,1):
                load.append(f'data modify storage love_letter:layout c{capacity}.swap.s{index}t{other} set value '+
                            j(trajectory(end,[target['x']+seat['tx'],.022,target['z']+seat['tz']],12,.32)))
    put('load',load)
    put('context','''
execute unless data storage love_letter:layout c8.seats run function love_letter:visual/load
scoreboard players operation #vis_table ll_ctx = @s ct_id
execute store result storage love_letter:visual cap int 1 run scoreboard players get @s ct_capacity
''')
    put('clear','''
scoreboard players operation #vis_table ll_ctx = @s ct_id
execute as @e[tag=ll.visual] if score @s ct_id = #vis_table ll_ctx run kill @s
''')
    put('clear_static','''
scoreboard players operation #vis_table ll_ctx = @s ct_id
execute as @e[tag=ll.visual,tag=!ll.fx,tag=!ll.box] if score @s ct_id = #vis_table ll_ctx run kill @s
''')
    put('setup','function love_letter:visual/refresh')
    put('refresh','''
function love_letter:system/context
function love_letter:visual/context
function love_letter:visual/clear_static
scoreboard players set #box_found ll_ctx 0
execute as @e[tag=ll.box] if score @s ct_id = #vis_table ll_ctx run scoreboard players set #box_found ll_ctx 1
execute if score #box_found ll_ctx matches 0 positioned ~ ~1.04 ~ summon minecraft:item_display run function love_letter:visual/box
execute as @e[type=minecraft:marker,tag=ll.board] run function love_letter:visual/participant
# 牌库相关字段仅展示双人局公开移出的三张牌。
data modify storage love_letter:visual public set value []
data modify storage love_letter:visual public set from entity @s data.love_letter.public
execute if data storage love_letter:visual public[0] run function love_letter:visual/public
''')
    put('seat','''
$data modify storage love_letter:visual seat_data set from storage love_letter:layout c$(cap).seats[$(seat_index)]
''')
    put('participant','''
scoreboard players add @s ll_v_point 0
execute store result storage love_letter:visual seat int 1 run scoreboard players get @s ll_seat
scoreboard players operation #vis_seat ll_ctx = @s ll_seat
scoreboard players remove #vis_seat ll_ctx 1
execute store result storage love_letter:visual seat_index int 1 run scoreboard players get #vis_seat ll_ctx
function love_letter:visual/seat with storage love_letter:visual
execute store result storage love_letter:visual seat_data.points int 1 run scoreboard players get @s ll_points
execute store result storage love_letter:visual seat_data.count int 1 run data get entity @s data.discards
data modify storage love_letter:visual seat_data.model set value "back"
execute store result storage love_letter:visual card int 1 run data get entity @s data.discards[-1]
execute if data entity @s data.discards[-1] run function love_letter:visual/resolve_model with storage love_letter:visual
data modify storage love_letter:visual seat_data.model set from storage love_letter:visual model
execute if data entity @s data.discards[-1] run function love_letter:visual/face_at with storage love_letter:visual seat_data
function love_letter:visual/label_at with storage love_letter:visual seat_data
execute if score @s ll_protect matches 1 run function love_letter:visual/protect_at with storage love_letter:visual seat_data
execute if score @s ll_points matches 1.. run function love_letter:visual/favor_at with storage love_letter:visual seat_data
execute if score @s ll_points > @s ll_v_point run function love_letter:visual/token
scoreboard players operation @s ll_v_point = @s ll_points
''')
    # 从临时公开牌值解析模型，不读取参与者的手牌分数。
    put('resolve_model',['data modify storage love_letter:visual model set value "back"']+
        [f'execute if data storage love_letter:visual {{card:{i}}} run data modify storage love_letter:visual model set value "{role}"' for i,role in enumerate(ROLES)])
    put('face_at','$execute positioned ~$(x) ~1.04 ~$(z) summon minecraft:item_display run function love_letter:visual/face with storage love_letter:visual seat_data')
    put('face','''
tag @s add ll.visual
tag @s add ll.face
scoreboard players operation @s ct_id = #vis_table ll_ctx
$scoreboard players set @s ll_v_seat $(seat)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[$(tx)f,0.022f,$(tz)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[0.44f,0.44f,0.44f]}}
''')
    put('label_at','$execute positioned ~$(x) ~1.39 ~$(z) summon minecraft:text_display run function love_letter:visual/label with storage love_letter:visual seat_data')
    put('label','''
tag @s add ll.visual
tag @s add ll.label
scoreboard players operation @s ct_id = #vis_table ll_ctx
$scoreboard players set @s ll_v_seat $(seat)
$data merge entity @s {text:{text:"$(seat)号位 · ♥$(points) · 弃$(count)",color:"gold"},billboard:"center",background:0,shadow:1b,see_through:0b,view_range:0.5f,line_width:240,transformation:{scale:[0.18f,0.18f,0.18f]}}
''')
    put('box','''
tag @s add ll.visual
tag @s add ll.box
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/box"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[-0.103125f,0.034375f,0f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],scale:[0.55f,0.55f,0.55f]}}
''')
    put('protect_at','$execute positioned ~$(x) ~1.043 ~$(z) summon minecraft:item_display run function love_letter:visual/protect with storage love_letter:visual seat_data')
    put('protect','''
tag @s add ll.visual
tag @s add ll.protect
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/protection"}},item_display:"none",Glowing:1b,glow_color_override:7526595,brightness:{block:15,sky:15},view_range:0.5f,shadow_radius:0f,transformation:{translation:[0f,0.25f,0f],right_rotation:[0f,1f,0f,0f],scale:[0.5f,0.5f,0.5f]}}
''')
    put('favor_at','$execute positioned ~$(favor_x) ~1.045 ~$(favor_z) summon minecraft:item_display run function love_letter:visual/favor')
    put('favor','''
tag @s add ll.visual
tag @s add ll.favor
scoreboard players operation @s ct_id = #vis_table ll_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/favor"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[0f,0.1f,0f],right_rotation:[0f,1f,0f,0f],scale:[0.2f,0.2f,0.2f]}}
''')
    public=[]
    for i,x in enumerate((-.42,0,.42)):
        public += [f'execute if data storage love_letter:visual public[{i}] run data modify storage love_letter:visual card set from storage love_letter:visual public[{i}]',
                   f'execute if data storage love_letter:visual public[{i}] run function love_letter:visual/resolve_model',
                   f'execute if data storage love_letter:visual public[{i}] positioned ~{x} ~1.045 ~0.48 summon minecraft:item_display run function love_letter:visual/public_face with storage love_letter:visual']
    put('public',public)
    put('public_face','''
tag @s add ll.visual
tag @s add ll.public
scoreboard players operation @s ct_id = #vis_table ll_ctx
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:love_letter/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[0.02f,0.02f,-0.02f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,1f,0f,0f],scale:[0.32f,0.32f,0.32f]}}
''')
    put('event','''
# 仅读取公开的 action.card、actor、target、eliminated，不访问 ll_hand 或 ll_extra。
function love_letter:system/context
function love_letter:visual/context
execute unless data entity @s data.love_letter.action.actor run return 0
data modify storage love_letter:visual seat set from entity @s data.love_letter.action.actor
data modify storage love_letter:visual card set from entity @s data.love_letter.action.card
data modify storage love_letter:visual target set from entity @s data.love_letter.action.target
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/resolve_model
data modify storage love_letter:visual seat_data.model set from storage love_letter:visual model
function love_letter:visual/play_path with storage love_letter:visual
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function love_letter:visual/play_fx with storage love_letter:visual seat_data
execute if data storage love_letter:visual {card:2} run function love_letter:visual/peek
execute if data storage love_letter:visual {card:7} run function love_letter:visual/swap
data modify storage love_letter:visual eliminated set from entity @s data.love_letter.action.eliminated
execute if data storage love_letter:visual eliminated[0] run function love_letter:visual/eliminated
''')
    put('event_seat','''
$scoreboard players set #vis_seat ll_ctx $(seat)
scoreboard players remove #vis_seat ll_ctx 1
execute store result storage love_letter:visual seat_index int 1 run scoreboard players get #vis_seat ll_ctx
function love_letter:visual/seat with storage love_letter:visual
''')
    put('play_path','$data modify storage love_letter:visual frames set from storage love_letter:layout c$(cap).play.s$(seat)')
    put('play_fx','''
function love_letter:visual/face with storage love_letter:visual seat_data
tag @s remove ll.face
tag @s add ll.fx
scoreboard players set @s ll_v_kind 1
data modify entity @s data.ll_frames set from storage love_letter:visual frames
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
''')
    put('token','''
function love_letter:visual/token_path with storage love_letter:visual
execute positioned ~ ~1.045 ~ summon minecraft:item_display run function love_letter:visual/token_fx
''')
    put('token_path','$data modify storage love_letter:visual frames set from storage love_letter:layout c$(cap).token.s$(seat)')
    put('token_fx','''
function love_letter:visual/favor
tag @s remove ll.favor
tag @s add ll.fx
scoreboard players set @s ll_v_kind 2
data modify entity @s data.ll_frames set from storage love_letter:visual frames
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
''')
    put('peek','''
data modify storage love_letter:visual saved_seat set from storage love_letter:visual seat
data modify storage love_letter:visual seat set from storage love_letter:visual target
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/peek_at with storage love_letter:visual seat_data
data modify storage love_letter:visual seat set from storage love_letter:visual saved_seat
''')
    put('peek_at','$particle minecraft:enchant ~$(x) ~1.35 ~$(z) 0.10 0.10 0.10 0.05 12 force @a[tag=ll.audience]')
    put('swap','''
data modify storage love_letter:visual saved_actor set from storage love_letter:visual seat
data modify storage love_letter:visual saved_target set from storage love_letter:visual target
function love_letter:visual/swap_one
data modify storage love_letter:visual seat set from storage love_letter:visual saved_target
data modify storage love_letter:visual target set from storage love_letter:visual saved_actor
function love_letter:visual/swap_one
data modify storage love_letter:visual seat set from storage love_letter:visual saved_actor
data modify storage love_letter:visual target set from storage love_letter:visual saved_target
''')
    put('swap_one','''
function love_letter:visual/event_seat with storage love_letter:visual
data modify storage love_letter:visual seat_data.model set value "back"
function love_letter:visual/swap_path with storage love_letter:visual
execute positioned ~ ~1.06 ~ summon minecraft:item_display run function love_letter:visual/play_fx with storage love_letter:visual seat_data
''')
    put('swap_path','$data modify storage love_letter:visual frames set from storage love_letter:layout c$(cap).swap.s$(seat)t$(target)')
    put('eliminated','''
data modify storage love_letter:visual seat set from storage love_letter:visual eliminated[0]
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/eliminated_at with storage love_letter:visual seat_data
data remove storage love_letter:visual eliminated[0]
execute if data storage love_letter:visual eliminated[0] run function love_letter:visual/eliminated
''')
    put('eliminated_at','$particle minecraft:angry_villager ~$(x) ~1.30 ~$(z) 0.10 0.12 0.10 0 4 force @a[tag=ll.audience]')
    put('tick','''
scoreboard players operation #vis_table ll_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=ll.fx] if score @s ct_id = #vis_table ll_ctx run function love_letter:visual/fx_tick
''')
    put('fx_tick','''
execute unless data entity @s data.ll_frames[0] run return run kill @s
data merge entity @s {start_interpolation:0,interpolation_duration:1}
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
''')
    print('Exported Love Letter table displays and public-only multi-tick card / favor animations.')


if __name__=='__main__':build()
