# -*- coding: utf-8 -*-
"""生成掼蛋公开牌面、双牌盒及逐刻动画；不读取玩家的隐藏手牌。"""
import json
import math
from boardgame_assets import PACK, text_file

ROOT = PACK/'data/guandan/function/visual'
SEATS = {
    4: [(0,-.91,0),(.91,0,-90),(0,.91,180),(-.91,0,90)],
    8: [(-.85,-1.38,0),(.85,-1.38,0),(1.38,-.85,-90),(1.38,.85,-90),
        (.85,1.38,180),(-.85,1.38,180),(-1.38,.85,90),(-1.38,-.85,90)]}
MODELS = [f'{s}_{r}' for s in ('c','d','h','s') for r in ('2','3','4','5','6','7','8','9','10','j','q','k','a')] + ['j_2','j_1']
OBJECTIVES = {'gd_v_seat':'dummy','gd_v_age':'dummy','gd_v_life':'dummy'}


def j(value): return json.dumps(value,ensure_ascii=False,separators=(',',':'))
def put(name,body): text_file(ROOT/(name+'.mcfunction'),'\n'.join(body) if isinstance(body,list) else body)
def turn(x,z,yaw):
    a=math.radians(yaw)
    return x*math.cos(a)+z*math.sin(a),-x*math.sin(a)+z*math.cos(a)


def path(start,end,count=8,arc=.12):
    out=[]
    for step in range(count+1):
        t=step/count;s=t*t*(3-2*t)
        out.append([round(start[0]+(end[0]-start[0])*s,6),round(start[1]+(end[1]-start[1])*s+4*t*(1-t)*arc,6),round(start[2]+(end[2]-start[2])*s,6)])
    return out


def build():
    load=[f'scoreboard objectives add {key} {kind}' for key,kind in OBJECTIVES.items()]
    for capacity,seats in SEATS.items():
        scale=.43 if capacity==4 else .47
        values=[]
        for seat,(x,z,yaw) in enumerate(seats,1):
            # 八人桌实际仅四方参加；各方的公开牌组居中，避免相邻角座同时出炸弹时相互覆盖。
            if capacity==8:
                x,z={0:(0,-1.25),-90:(1.25,0),180:(0,1.25),90:(-1.25,0)}[yaw]
            a=math.radians(yaw)/2;q=math.sqrt(.5)
            tx,tz=turn(scale/16,-scale/16,yaw)
            values.append(dict(x=x,z=z,lx=round(x*1.36,5),lz=round(z*1.36,5),yaw=yaw,seat=seat,scale=scale,tx=round(tx,7),tz=round(tz,7),ty=round(scale/16,7),
                qx=round(q*math.cos(a),8),qy=round(q*math.sin(a),8),qz=round(-q*math.sin(a),8),qw=round(q*math.cos(a),8)))
        load.append(f'data modify storage guandan:layout c{capacity}.seats set value '+j(values))
        for seat,value in enumerate(values,1):
            for count in range(1,11):
                cards=[]
                span=1.0 if capacity==4 else 1.20
                gap=min(.19,span/max(1,count-1))
                for index in range(count):
                    dx,dz=turn((index-(count-1)/2)*gap,0,seats[seat-1][2])
                    final=[value['x']+value['tx']+dx,value['ty']+index*.0007,value['z']+value['tz']+dz]
                    ox,oz,_=seats[seat-1]
                    start=[ox*1.12+value['tx']+dx,.38+index*.01,oz*1.12+value['tz']+dz]
                    cards.append(dict(value,position=[round(n,7) for n in final],path=path(start,final)))
                load.append(f'data modify storage guandan:layout c{capacity}.s{seat}.n{count} set value '+j(cards))
            for target,dest in enumerate(values,1):
                start=[value['x']+value['tx'],.10,value['z']+value['tz']]
                end=[dest['x']+value['tx'],.10,dest['z']+value['tz']]
                load.append(f'data modify storage guandan:layout c{capacity}.s{seat}.t{target} set value '+j(dict(value,path=path(start,end,12,.38))))
    put('load',load)
    put('context',r'''
execute unless data storage guandan:layout c8.seats run function guandan:visual/load
scoreboard players operation #vis_table gd_ctx = @s ct_id
execute store result storage guandan:visual cap int 1 run scoreboard players get @s ct_capacity
''')
    put('setup','function guandan:visual/refresh')
    put('clear',r'''
scoreboard players operation #vis_table gd_ctx = @s ct_id
execute as @e[tag=gd.visual] if score @s ct_id = #vis_table gd_ctx run kill @s
''')
    put('refresh',r'''
function guandan:system/context
function guandan:visual/context
execute as @e[tag=gd.visual,tag=!gd.fx,tag=!gd.box] if score @s ct_id = #vis_table gd_ctx run kill @s
scoreboard players set #box_found gd_ctx 0
execute as @e[tag=gd.box] if score @s ct_id = #vis_table gd_ctx run scoreboard players add #box_found gd_ctx 1
execute unless score #box_found gd_ctx matches 2 run function guandan:visual/boxes
execute as @e[type=minecraft:marker,tag=gd.board] run function guandan:visual/participant
execute if score @s gd_state matches 1..5 positioned ~ ~1.075 ~ summon minecraft:text_display run function guandan:visual/status
''')
    put('boxes',r'''
execute as @e[tag=gd.box] if score @s ct_id = #vis_table gd_ctx run kill @s
execute positioned ~-0.22 ~1.04 ~0.55 summon minecraft:item_display run function guandan:visual/box
execute positioned ~0.22 ~1.04 ~0.55 summon minecraft:item_display run function guandan:visual/box
''')
    put('box',r'''
tag @s add gd.visual
tag @s add gd.box
scoreboard players operation @s ct_id = #vis_table gd_ctx
data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:cardbox"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[-0.07125f,0.07625f,0f],left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,1f,0f,0f],scale:[0.38f,0.38f,0.38f]}}
''')
    put('seat',r'''
$data modify storage guandan:visual seat_data set from storage guandan:layout c$(cap).seats[$(seat_index)]
''')
    put('participant',r'''
execute store result storage guandan:visual seat int 1 run scoreboard players get @s gd_seat
scoreboard players operation #vis_seat gd_ctx = @s gd_seat
scoreboard players operation #vis_index gd_ctx = @s gd_seat
scoreboard players remove #vis_index gd_ctx 1
execute store result storage guandan:visual seat_index int 1 run scoreboard players get #vis_index gd_ctx
function guandan:visual/seat with storage guandan:visual
data modify storage guandan:visual seat_data.name set value {text:"玩家"}
data modify storage guandan:visual seat_data.name set from entity @s data.gd_name
data modify storage guandan:visual seat_data.line set value ""
data modify storage guandan:visual seat_data.line set from entity @s data.last_label
execute store result storage guandan:visual seat_data.team int 1 run scoreboard players get @s gd_team
execute store result storage guandan:visual seat_data.rank int 1 run scoreboard players get @s gd_rank
data modify storage guandan:visual seat_data.count_text set value ""
execute if entity @e[tag=gd.current,scores={gd_show=1},limit=1] run function guandan:visual/count_text
data modify storage guandan:visual seat_data.turn_text set value ""
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run data modify storage guandan:visual seat_data.turn_text set value " ◀"
# Seat labels removed; player details remain in the HUD.
# 只读取本桌公开出牌；绝不读取 gd.card 的玩家持有牌面。
data modify storage guandan:visual public set value []
data modify storage guandan:visual public set from entity @s data.last_play
scoreboard players set #playing gd_ctx 0
execute as @e[tag=gd.fx,tag=gd.playing] if score @s ct_id = #vis_table gd_ctx if score @s gd_v_seat = #vis_seat gd_ctx run scoreboard players set #playing gd_ctx 1
execute if data storage guandan:visual public[0] if score #playing gd_ctx matches 0 run function guandan:visual/public_group
''')
    put('count_text',r'''
execute store result storage guandan:visual count int 1 run scoreboard players get @s gd_count
function guandan:visual/count_string with storage guandan:visual
''')
    put('count_string','$data modify storage guandan:visual seat_data.count_text set value " · 余$(count)张"')
    put('label_at','$execute positioned ~$(lx) ~1.075 ~$(lz) summon minecraft:text_display run function guandan:visual/label with storage guandan:visual seat_data')
    put('label',r'''
tag @s add gd.visual
tag @s add gd.label
scoreboard players operation @s ct_id = #vis_table gd_ctx
$scoreboard players set @s gd_v_seat $(seat)
$data merge entity @s {text:{text:"",extra:[$(name),{text:" · 队$(team)$(count_text)$(turn_text)",color:"gray"}]},billboard:"fixed",Rotation:[$(yaw)f,-90f],background:0,shadow:0b,view_range:0.5f,line_width:300,transformation:{scale:[0.13f,0.13f,0.13f]}}
''')
    put('status',r'''
tag @s add gd.visual
tag @s add gd.status
scoreboard players operation @s ct_id = #vis_table gd_ctx
data merge entity @s {text:{text:"掼蛋",color:"gold",extra:[{text:" · 本副 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_round"}},{text:"\n队0 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_team0"}},{text:"级 / 队1 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_team1"}},{text:"级 · 打 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_level"}},{text:"\n轮到 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_turn"}},{text:" 号位 · 逆时针"}]},billboard:"fixed",Rotation:[0f,-90f],background:0,shadow:0b,view_range:0.5f,line_width:340,transformation:{scale:[0.14f,0.14f,0.14f]}}
# text_display 会立即解析 selector/score；刷新时上下文只包含当前桌。
execute if entity @e[tag=gd.current,scores={gd_state=0},limit=1] run data modify entity @s text set value {text:"掼蛋 · 四人对家",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=1},limit=1] run data modify entity @s text set value {text:"掼蛋 · 正在发牌",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=1},limit=1] run data modify entity @s text set value {text:"掼蛋 · 选择进贡",color:"gold"}
execute if entity @e[tag=gd.current,scores={gd_state=2,gd_phase=2},limit=1] run data modify entity @s text set value {text:"掼蛋 · 选择还牌",color:"gold"}
''')
    put('public_group',r'''
execute store result storage guandan:visual count int 1 run data get storage guandan:visual public
scoreboard players set #index gd_ctx 0
scoreboard players set #effect gd_ctx 0
function guandan:visual/group_layout with storage guandan:visual
function guandan:visual/group_loop
''')
    put('group_layout','$data modify storage guandan:visual positions set from storage guandan:layout c$(cap).s$(seat).n$(count)')
    put('group_loop',r'''
execute unless data storage guandan:visual public[0] run return 0
data modify storage guandan:visual type set from storage guandan:visual public[0]
data modify storage guandan:visual card set from storage guandan:visual positions[0]
function guandan:visual/model with storage guandan:visual
data modify storage guandan:visual card.model set from storage guandan:visual model
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function guandan:visual/face with storage guandan:visual card
data remove storage guandan:visual public[0]
data remove storage guandan:visual positions[0]
scoreboard players add #index gd_ctx 1
execute if score #index gd_ctx matches ..9 if data storage guandan:visual public[0] run function guandan:visual/group_loop
''')
    put('model',['data modify storage guandan:visual model set value "back"']+[f'execute if data storage guandan:visual {{type:{i}}} run data modify storage guandan:visual model set value "{model}"' for i,model in enumerate(MODELS)])
    put('face',r'''
tag @s add gd.visual
tag @s add gd.face
scoreboard players operation @s ct_id = #vis_table gd_ctx
$scoreboard players set @s gd_v_seat $(seat)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:poker/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,interpolation_duration:1,start_interpolation:0,transformation:{translation:$(position),left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]}}
execute if score #effect gd_ctx matches 1 run function guandan:visual/playing with storage guandan:visual card
''')
    put('playing',r'''
tag @s add gd.fx
tag @s add gd.playing
scoreboard players set @s gd_v_age 0
scoreboard players set @s gd_v_life 8
$data merge entity @s {data:{path:$(path)},transformation:{translation:$(path)}}
# path 是位置列表，使用首项作为初始 translation。
data modify entity @s transformation.translation set from entity @s data.path[0]
data remove entity @s data.path[0]
'''.replace(',transformation:{translation:$(path)}',''))
    put('play',r'''
function guandan:system/context
function guandan:visual/context
data modify storage guandan:visual seat set from entity @s data.guandan.action.seat
data modify storage guandan:visual public set from entity @s data.guandan.action.cardtypes
execute store result storage guandan:visual count int 1 run data get storage guandan:visual public
function guandan:visual/group_layout with storage guandan:visual
scoreboard players set #index gd_ctx 0
scoreboard players set #effect gd_ctx 1
function guandan:visual/group_loop
function guandan:visual/refresh
''')
    put('collect',r'''
function guandan:visual/context
# 旧公开实体本身即动画快照，不再依赖已清空的逻辑 last_play。
execute as @e[type=minecraft:item_display,tag=gd.face,tag=!gd.fx] if score @s ct_id = #vis_table gd_ctx run function guandan:visual/collect_face
function guandan:visual/refresh
''')
    put('collect_face',r'''
tag @s add gd.fx
tag @s add gd.collecting
scoreboard players set @s gd_v_age 0
scoreboard players set @s gd_v_life 8
data merge entity @s {interpolation_duration:8,start_interpolation:0,transformation:{translation:[0f,0.08f,0f],scale:[0.15f,0.15f,0.15f]}}
''')
    put('tribute',r'''
function guandan:system/context
function guandan:visual/context
data modify storage guandan:visual exchanges set value []
data modify storage guandan:visual exchanges set from entity @s data.guandan.exchange
execute if data storage guandan:visual exchanges[0] run function guandan:visual/tribute_loop
function guandan:visual/refresh
''')
    put('tribute_loop',r'''
data modify storage guandan:visual exchange set from storage guandan:visual exchanges[0]
function guandan:visual/tribute_path with storage guandan:visual exchange
data modify storage guandan:visual type set from storage guandan:visual exchange.type
function guandan:visual/model
data modify storage guandan:visual card.model set from storage guandan:visual model
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function guandan:visual/exchange_face with storage guandan:visual card
data remove storage guandan:visual exchanges[0]
execute if data storage guandan:visual exchanges[0] run function guandan:visual/tribute_loop
''')
    put('tribute_path','$data modify storage guandan:visual card set from storage guandan:layout c$(cap).s$(from).t$(to)')
    # cap 单独并入参数，避免一次宏跨两个 storage 读取字段。
    put('tribute_loop',(ROOT/'tribute_loop.mcfunction').read_text(encoding='utf8').replace('function guandan:visual/tribute_path','data modify storage guandan:visual exchange.cap set from storage guandan:visual cap\nfunction guandan:visual/tribute_path'))
    put('exchange_face',r'''
tag @s add gd.visual
tag @s add gd.fx
tag @s add gd.exchange
scoreboard players operation @s ct_id = #vis_table gd_ctx
scoreboard players set @s gd_v_age 0
scoreboard players set @s gd_v_life 12
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:poker/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,interpolation_duration:1,start_interpolation:0,transformation:{left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f]},data:{path:$(path)}}
data modify entity @s transformation.translation set from entity @s data.path[0]
data remove entity @s data.path[0]
''')
    put('upgrade',r'''
function guandan:visual/context
execute store result storage guandan:visual steps int 1 run scoreboard players get @s gd_steps
execute positioned ~ ~2.13 ~ summon minecraft:text_display run function guandan:visual/upgrade_text with storage guandan:visual
''')
    put('upgrade_text',r'''
tag @s add gd.visual
tag @s add gd.fx
tag @s add gd.upgrade
scoreboard players operation @s ct_id = #vis_table gd_ctx
scoreboard players set @s gd_v_age 0
scoreboard players set @s gd_v_life 30
$data merge entity @s {text:{text:"升 $(steps) 级",color:"gold",bold:1b},billboard:"center",background:0,shadow:1b,view_range:0.5f,interpolation_duration:30,start_interpolation:0,transformation:{translation:[0f,0.32f,0f],scale:[0.25f,0.25f,0.25f]}}
''')
    put('tick',r'''
scoreboard players operation #vis_table gd_ctx = @s ct_id
execute as @e[tag=gd.fx] if score @s ct_id = #vis_table gd_ctx run function guandan:visual/fx_tick
''')
    put('fx_tick',r'''
scoreboard players add @s gd_v_age 1
execute if data entity @s data.path[0] run data modify entity @s transformation.translation set from entity @s data.path[0]
execute if data entity @s data.path[0] run data merge entity @s {start_interpolation:0}
data remove entity @s data.path[0]
execute if score @s gd_v_age < @s gd_v_life run return 0
execute unless entity @s[tag=gd.playing] run return run kill @s
tag @s remove gd.fx
tag @s remove gd.playing
data remove entity @s data.path
''')
    # 高级别按J/Q/K/A显示，玩家无需把11～14换算成牌点。
    body=(ROOT/'status.mcfunction').read_text(encoding='utf8')
    body=body.replace('# text_display', 'function guandan:visual/status_fields\n# text_display')
    put('status',body)
    fields=[]
    for field,objective in [('level','gd_level'),('level0','gd_team0'),('level1','gd_team1')]:
        fields.append(f'execute store result storage guandan:visual {field} int 1 run scoreboard players get @e[tag=gd.current,limit=1] {objective}')
        for value,label in [(11,'J'),(12,'Q'),(13,'K'),(14,'A')]:
            fields.append(f'execute if score @e[tag=gd.current,limit=1] {objective} matches {value} run data modify storage guandan:visual {field} set value "{label}"')
    fields.append('function guandan:visual/status_text with storage guandan:visual')
    put('status_fields',fields)
    put('status_text',r'''$data modify entity @s text set value {text:"掼蛋 · 打$(level)",color:"gold",extra:[{text:"\n队0 $(level0)级 / 队1 $(level1)级"},{text:"\n轮到 "},{score:{name:"@e[tag=gd.current,limit=1]",objective:"gd_turn"}},{text:" 号位 · 逆时针"}]}''')
    put('shuffle',r'''
function guandan:visual/context
data modify storage guandan:visual card set from storage guandan:layout c4.seats[0]
data modify storage guandan:visual card.model set value "back"
data modify storage guandan:visual card.path set value [[-0.22,0.18,0.0],[-0.17,0.22,-0.06],[-0.09,0.25,-0.10],[0.0,0.26,-0.12],[0.09,0.25,-0.10],[0.17,0.22,-0.06],[0.22,0.18,0.0],[0.17,0.15,0.06],[0.09,0.12,0.1],[0.0,0.1,0.12],[-0.09,0.08,0.10],[-0.17,0.08,0.06],[-0.22,0.08,0.0]]
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function guandan:visual/exchange_face with storage guandan:visual card
''')
    print('Guandan public visuals generated: two permanent boxes, 4/8 seat layouts, public-only play/collect/tribute/upgrade animations.')


if __name__=='__main__': build()
