# -*- coding: utf-8 -*-
"""31格共享路径、有限选手实体、按桌事件动画；表现不重复结算规则。"""
import json
import math
from build_magical_athlete_game import PACK, put


def js(v):return json.dumps(v,ensure_ascii=False,separators=(',',':'))


def main():
    path=json.loads((PACK/'tools/magical_athlete_track.json').read_text(encoding='utf-8'))['layout']
    load=[]
    for cap in (4,8):
        size=path['footprints'][str(cap)]
        for orient in (0,1):
            rows=[]
            for pawn in range(6):
                poses=[]
                for x,z in path['positions']:
                    x,z=(x-8)*size/16,(z-8)*size/16
                    if orient:x,z=-z,x
                    poses.append({'x':round(x,6),'y':.035,'z':round(z,6),'scale':round(size*.067,6)})
                rows.append(poses)
            cells={1:(.067,[(0,0)]),2:(.045,[(-.023,0),(.023,0)]),3:(.032,[(-.031,0),(0,0),(.031,0)]),4:(.033,[(-.02,-.02),(.02,-.02),(-.02,.02),(.02,.02)]),5:(.026,[(-.027,-.018),(0,-.018),(.027,-.018),(-.014,.018),(.014,.018)]),6:(.026,[(-.027,-.018),(0,-.018),(.027,-.018),(-.027,.018),(0,.018),(.027,.018)])}
            groups=[[]]
            for count in range(1,7):
                scale,offsets=cells[count];group=[]
                for dx,dz in offsets:
                    if orient:dx,dz=-dz,dx
                    group.append({'dx':round(dx*size,6),'dz':round(dz*size,6),'scale':round(scale*size,6)})
                groups.append(group)
            load += [f'data modify storage magical_athlete:layout c{cap}o{orient} set value '+js({'size':size,'pawns':rows,'groups':groups,'board_rotation':[0,-round(math.sqrt(.5),8),0,round(math.sqrt(.5),8)] if orient else [0,0,0,1]})]
    half=round(math.sqrt(.5),8)
    quats={1:[0,0,0,1],6:[1,0,0,0],2:[half,0,0,half],5:[-half,0,0,half],3:[0,0,half,half],4:[0,0,-half,half]}
    for die,q in quats.items():
        frames=[]
        for frame in range(13):
            t=frame/12;angle=(1-t)*math.pi*4
            spin=[math.sin(angle/2),0,0,math.cos(angle/2)]
            a,b,c,d=spin;A,B,C,D=q
            rotation=[d*A+a*D+b*C-c*B,d*B-a*C+b*D+c*A,d*C+a*B-b*A+c*D,d*D-a*A-b*B-c*C]
            frames.append({'x':.0,'y':round(.12+math.sin(t*math.pi)*.42,7),'z':0,'scale':.23,'qx':round(rotation[0],7),'qy':round(rotation[1],7),'qz':round(rotation[2],7),'qw':round(rotation[3],7)})
        load += [f'data modify storage magical_athlete:layout dice{die} set value '+js(frames)]
    put('visual/load',load)
    put('visual/context',['scoreboard players operation #vis_table ma_ctx = @s ct_id','execute store result storage magical_athlete:visual cap int 1 run scoreboard players get @s ct_capacity','execute store result storage magical_athlete:visual orient int 1 run scoreboard players get @s ma_orient','function magical_athlete:visual/layout with storage magical_athlete:visual'])
    put('visual/layout','$data modify storage magical_athlete:visual layout set from storage magical_athlete:layout c$(cap)o$(orient)')
    put('visual/clear',['scoreboard players operation #vis_table ma_ctx = @s ct_id','execute as @e[tag=ma.visual] if score @s ct_id = #vis_table ma_ctx run kill @s','scoreboard players set @s ma_vtimer 0','scoreboard players set @s ma_vframe 0'])
    put('visual/preview',['function magical_athlete:visual/clear','function magical_athlete:visual/context','data modify storage magical_athlete:visual track set value "mild"','execute if score @s ma_track matches 2 run data modify storage magical_athlete:visual track set value "wild"','function magical_athlete:visual/board_spawn with storage magical_athlete:visual','function magical_athlete:visual/dice_spawn'])
    put('visual/refresh',['function magical_athlete:visual/clear','function magical_athlete:visual/context','data modify storage magical_athlete:visual track set value "mild"','execute if data entity @s data.magical_athlete{track:1} run data modify storage magical_athlete:visual track set value "wild"','function magical_athlete:visual/board_spawn with storage magical_athlete:visual','function magical_athlete:visual/dice_spawn','function magical_athlete:visual/dice_restore']+[f'execute if data entity @s data.magical_athlete.racers[{i}] run function magical_athlete:visual/racer_spawn {{index:{i}}}' for i in range(6)])
    put('visual/board_spawn',['execute positioned ~ ~1.035 ~ summon minecraft:item_display run function magical_athlete:visual/board_init with storage magical_athlete:visual'])
    put('visual/board_init',['tag @s add ma.visual','tag @s add ma.board','scoreboard players operation @s ct_id = #vis_table ma_ctx','$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/board/$(track)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}','data modify storage magical_athlete:visual board set from storage magical_athlete:visual layout','function magical_athlete:visual/board_pose with storage magical_athlete:visual board'])
    put('visual/board_pose','$data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[$(size)f,$(size)f,$(size)f],left_rotation:$(board_rotation),right_rotation:[0f,1f,0f,0f]}}')
    put('visual/racer_spawn','''
$data modify storage magical_athlete:visual racer set from entity @s data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:visual racer{char:-1} run return 0
execute if data storage magical_athlete:visual racer{owner:0} run return 0
$data modify storage magical_athlete:visual racer.index set value $(index)
function magical_athlete:visual/racer_data with storage magical_athlete:visual racer
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function magical_athlete:visual/racer_init with storage magical_athlete:visual
''')
    put('visual/racer_data','''
$data modify storage magical_athlete:visual model set from storage magical_athlete:characters chars[$(char)].slug
$data modify storage magical_athlete:visual index set value $(index)
$data modify storage magical_athlete:visual pose set from storage magical_athlete:visual layout.pawns[$(index)][$(pos)]
execute unless data storage magical_athlete:visual racer{status:2} run function magical_athlete:visual/stack_pose with storage magical_athlete:visual racer
$execute if predicate {condition:"minecraft:value_check",value:$(status),range:2} run data modify storage magical_athlete:visual pose.scale set value 0.001
data modify storage magical_athlete:visual pose.duration set value 0
''')
    stack=['scoreboard players set #stack_count ma_ctx 0','scoreboard players set #stack_rank ma_ctx 0','$scoreboard players set #stack_index ma_ctx $(index)','$scoreboard players set #stack_pos ma_ctx $(pos)']
    for other in range(6):
        stack +=[f'execute store result score #probe_pos ma_ctx run data get entity @s data.magical_athlete.racers[{other}].pos',f'execute store result score #probe_status ma_ctx run data get entity @s data.magical_athlete.racers[{other}].status']
        condition='execute if score #probe_pos ma_ctx = #stack_pos ma_ctx if score #probe_status ma_ctx matches 0..1'
        stack += [condition+' run scoreboard players add #stack_count ma_ctx 1',condition+f' if score #stack_index ma_ctx matches {other+1}.. run scoreboard players add #stack_rank ma_ctx 1']
    stack +=['execute if score #stack_count ma_ctx matches 0 run return 0','execute store result storage magical_athlete:visual stack.count int 1 run scoreboard players get #stack_count ma_ctx','execute store result storage magical_athlete:visual stack.rank int 1 run scoreboard players get #stack_rank ma_ctx','function magical_athlete:visual/stack_get with storage magical_athlete:visual stack']
    put('visual/stack_pose',stack)
    put('visual/stack_get',['$data modify storage magical_athlete:visual offset set from storage magical_athlete:visual layout.groups[$(count)][$(rank)]','data modify storage magical_athlete:visual pose.scale set from storage magical_athlete:visual offset.scale']+sum(([f'execute store result score #stack_base ma_ctx run data get storage magical_athlete:visual pose.{axis} 1000000',f'execute store result score #stack_delta ma_ctx run data get storage magical_athlete:visual offset.d{axis} 1000000','scoreboard players operation #stack_base ma_ctx += #stack_delta ma_ctx',f'execute store result storage magical_athlete:visual pose.{axis} double 0.000001 run scoreboard players get #stack_base ma_ctx'] for axis in ('x','z')),[]))
    put('visual/racer_init','''
tag @s add ma.visual
tag @s add ma.racer
scoreboard players operation @s ct_id = #vis_table ma_ctx
$scoreboard players set @s ma_vid $(index)
$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/racer/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0.04f,view_range:0.5f}
function magical_athlete:visual/racer_pose with storage magical_athlete:visual pose
''')
    put('visual/racer_pose', [
        # item_display 将模型 Y=8 作为原点；立牌底面为 Y=0，需补偿半个缩放高度。
        # 在最后应用姿态时补偿，覆盖静止、同格缩小、行走和传送的每一帧。
        '$data modify storage magical_athlete:visual draw_pose set value {x:$(x),y:$(y),z:$(z),scale:$(scale),duration:$(duration)}',
        'execute store result score #racer_y ma_ctx run data get storage magical_athlete:visual draw_pose.y 1000000',
        'execute store result score #racer_lift ma_ctx run data get storage magical_athlete:visual draw_pose.scale 500000',
        'scoreboard players operation #racer_y ma_ctx += #racer_lift ma_ctx',
        'execute store result storage magical_athlete:visual draw_pose.y double 0.000001 run scoreboard players get #racer_y ma_ctx',
        'function magical_athlete:visual/racer_pose_apply with storage magical_athlete:visual draw_pose',
    ])
    put('visual/racer_pose_apply','$data merge entity @s {start_interpolation:0,interpolation_duration:$(duration),transformation:{translation:[$(x)f,$(y)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}')
    put('visual/dice_spawn','execute positioned ~ ~1.04 ~ summon minecraft:item_display run function magical_athlete:visual/dice_init')
    put('visual/dice_init',['tag @s add ma.visual','tag @s add ma.die','scoreboard players operation @s ct_id = #vis_table ma_ctx','data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/dice"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0.05f,view_range:0.5f,transformation:{translation:[0f,0.12f,0f],scale:[0.23f,0.23f,0.23f],right_rotation:[0f,1f,0f,0f]}}'])
    put('visual/dice_restore',['scoreboard players set #saved_die ma_ctx 0','execute store result score #saved_die ma_ctx run data get entity @s data.magical_athlete.dice','execute unless score #saved_die ma_ctx matches 1..6 run return 0','execute store result storage magical_athlete:visual die int 1 run scoreboard players get #saved_die ma_ctx','data modify storage magical_athlete:visual frame set value 12','function magical_athlete:visual/die_get with storage magical_athlete:visual'])
    put('visual/animate','''
function magical_athlete:visual/context
data modify entity @s data.magical_athlete.visual_queue set from entity @s data.magical_athlete.events
scoreboard players set @s ma_anim 0
execute unless data entity @s data.magical_athlete.visual_queue[0] run return 0
scoreboard players set @s ma_anim 1
scoreboard players set @s ma_vtimer 0
''')
    put('visual/tick','''
execute if score @s ct_paused matches 1 run return 0
function magical_athlete:visual/context
execute if score @s ma_vtimer matches 0 run function magical_athlete:visual/event_begin
execute unless score @s ma_anim matches 1.. run return 0
data modify storage magical_athlete:visual event set from entity @s data.magical_athlete.visual_event
scoreboard players add @s ma_vframe 1
function magical_athlete:visual/event_tick with storage magical_athlete:visual event
scoreboard players remove @s ma_vtimer 1
execute if score @s ma_vtimer matches 0 run function magical_athlete:visual/event_end
''')
    put('visual/event_begin','''
execute unless data entity @s data.magical_athlete.visual_queue[0] run return run function magical_athlete:game/after_animation
data modify entity @s data.magical_athlete.visual_event set from entity @s data.magical_athlete.visual_queue[0]
data remove entity @s data.magical_athlete.visual_queue[0]
data modify storage magical_athlete:visual event set from entity @s data.magical_athlete.visual_event
scoreboard players set @s ma_vtimer 12
execute if score @s ma_speed matches 1 run scoreboard players set @s ma_vtimer 6
scoreboard players set @s ma_vframe 0
function magical_athlete:visual/event_sound with storage magical_athlete:visual event
function magical_athlete:visual/event_prop with storage magical_athlete:visual event
function magical_athlete:visual/event_announce with storage magical_athlete:visual event
''')
    sounds={1:'step',2:'warp',3:'trip',4:'land',5:'trip',6:'finish',7:'coin',8:'skill',9:'roll'}
    put('visual/event_sound',[f'$execute if predicate {{condition:"minecraft:value_check",value:$(kind),range:{kind}}} run function magical_athlete:sound/{sound}' for kind,sound in sounds.items()]+['$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:{min:2,max:8}} run particle minecraft:happy_villager ~ ~1.3 ~ 0.6 0.1 0.6 0.02 10 normal @a[tag=ma.audience]','$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run particle minecraft:firework ~ ~1.5 ~ 0.7 0.3 0.7 0.08 20 normal @a[tag=ma.audience]'])
    put('visual/event_tick','''
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:1} run function magical_athlete:visual/move_frame with storage magical_athlete:visual event
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:2} run function magical_athlete:visual/warp_frame with storage magical_athlete:visual event
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:9} run function magical_athlete:visual/dice_frame with storage magical_athlete:visual event
''')
    put('visual/move_frame','''
$scoreboard players set #v_from ma_ctx $(from)
$scoreboard players set #v_to ma_ctx $(to)
scoreboard players operation #v_delta ma_ctx = #v_to ma_ctx
scoreboard players operation #v_delta ma_ctx -= #v_from ma_ctx
scoreboard players operation #v_delta ma_ctx *= @s ma_vframe
scoreboard players set #v_duration ma_ctx 12
execute if score @s ma_speed matches 1 run scoreboard players set #v_duration ma_ctx 6
scoreboard players operation #v_delta ma_ctx /= #v_duration ma_ctx
scoreboard players operation #v_delta ma_ctx += #v_from ma_ctx
execute if score #v_delta ma_ctx matches ..-1 run scoreboard players set #v_delta ma_ctx 0
execute if score #v_delta ma_ctx matches 31.. run scoreboard players set #v_delta ma_ctx 30
execute store result storage magical_athlete:visual position int 1 run scoreboard players get #v_delta ma_ctx
$data modify storage magical_athlete:visual pawn set value $(pawn)
function magical_athlete:visual/move_to with storage magical_athlete:visual
''')
    put('visual/warp_frame',['$data modify storage magical_athlete:visual position set value $(to)','$data modify storage magical_athlete:visual pawn set value $(pawn)','execute if score @s ma_vframe matches 6 run function magical_athlete:visual/move_to with storage magical_athlete:visual','execute if score @s ma_speed matches 1 if score @s ma_vframe matches 3 run function magical_athlete:visual/move_to with storage magical_athlete:visual'])
    put('visual/move_to','''
$data modify storage magical_athlete:visual pose set from storage magical_athlete:visual layout.pawns[$(pawn)][$(position)]
data modify storage magical_athlete:visual pose.duration set value 1
$execute as @e[tag=ma.racer,scores={ma_vid=$(pawn)}] if score @s ct_id = #vis_table ma_ctx run function magical_athlete:visual/racer_pose with storage magical_athlete:visual pose
''')
    put('visual/dice_frame','''
scoreboard players operation #v_frame ma_ctx = @s ma_vframe
execute if score @s ma_speed matches 1 run scoreboard players operation #v_frame ma_ctx += @s ma_vframe
execute if score #v_frame ma_ctx matches 13.. run scoreboard players set #v_frame ma_ctx 12
execute store result storage magical_athlete:visual frame int 1 run scoreboard players get #v_frame ma_ctx
$data modify storage magical_athlete:visual die set value $(die)
function magical_athlete:visual/die_get with storage magical_athlete:visual
''')
    put('visual/die_get',['$data modify storage magical_athlete:visual die_pose set from storage magical_athlete:layout dice$(die)[$(frame)]','execute as @e[tag=ma.die] if score @s ct_id = #vis_table ma_ctx run function magical_athlete:visual/die_pose with storage magical_athlete:visual die_pose'])
    put('visual/die_pose','$data merge entity @s {start_interpolation:0,interpolation_duration:1,transformation:{translation:[$(x)f,$(y)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f],left_rotation:[$(qx)f,$(qy)f,$(qz)f,$(qw)f],right_rotation:[0f,1f,0f,0f]}}')
    put('visual/event_prop',['data modify storage magical_athlete:visual prop set value "flag"']+[f'$execute if predicate {{condition:"minecraft:value_check",value:$(kind),range:{kind}}} run data modify storage magical_athlete:visual prop set value "{prop}"' for kind,prop in {2:'portal',3:'trip',4:'flag',5:'trip',6:'medal_gold',7:'coin',8:'rocket',9:'flag'}.items()]+['$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run function magical_athlete:visual/medal with storage magical_athlete:visual event','$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:{min:2,max:8}} run execute positioned ~ ~1.2 ~ summon minecraft:item_display run function magical_athlete:visual/prop_init with storage magical_athlete:visual'])
    put('visual/medal',['scoreboard players set #silver ma_ctx -1','execute store result score #silver ma_ctx run data get entity @s data.magical_athlete.finishers[1]','$scoreboard players set #crossed ma_ctx $(pawn)','execute if score #silver ma_ctx = #crossed ma_ctx run data modify storage magical_athlete:visual prop set value "medal_silver"'])
    put('visual/prop_init',['tag @s add ma.visual','tag @s add ma.event_prop','scoreboard players operation @s ct_id = #vis_table ma_ctx','$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:magical_athlete/prop/$(prop)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f,transformation:{translation:[0f,0.12f,0f],scale:[0.35f,0.35f,0.35f],right_rotation:[0f,1f,0f,0f]}}'])
    put('visual/event_announce','''
$execute unless predicate {condition:"minecraft:value_check",value:$(kind),range:{min:6,max:9}} run return 0
$data modify storage magical_athlete:visual announcer set from entity @s data.magical_athlete.racers[$(pawn)]
execute if data storage magical_athlete:visual announcer{char:-1} run return 0
function magical_athlete:visual/announcer_name with storage magical_athlete:visual announcer
$data modify storage magical_athlete:visual announcement.kind set value $(kind)
$data modify storage magical_athlete:visual announcement.die set value $(die)
$data modify storage magical_athlete:visual announcement.amount set value $(amount)
function magical_athlete:visual/announcement with storage magical_athlete:visual announcement
''')
    put('visual/announcer_name',['$data modify storage magical_athlete:visual announcement.name set from storage magical_athlete:characters chars[$(char)].name','$data modify storage magical_athlete:visual announcement.owner set from entity @s data.magical_athlete.p$(owner).name'])
    put('visual/announcement','''
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:9} run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] ",color:"gold"},$(owner),{text:" · $(name)掷出$(die)点",color:"yellow"}]
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:6} run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] ",color:"gold"},$(owner),{text:" · $(name)冲过终点！",color:"green"}]
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:7} run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] ",color:"gold"},$(owner),{text:" · $(name)积分变化$(amount)分",color:"aqua"}]
''')
    put('visual/event_end',['execute as @e[tag=ma.event_prop] if score @s ct_id = #vis_table ma_ctx run kill @s','execute unless data entity @s data.magical_athlete.visual_queue[0] run function magical_athlete:game/after_animation'])


if __name__=='__main__':main()
