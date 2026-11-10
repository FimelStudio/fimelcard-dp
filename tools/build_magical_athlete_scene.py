"""运动会持续场景：复用实体、沿赛道连续插值、桌面公开信息。"""
import json
from build_magical_athlete_game import PACK,put

ROOT=PACK/'data/magical_athlete/function'


def append(name,body):
    old=(ROOT/(name+'.mcfunction')).read_text(encoding='utf-8').split('# scene-v2')[0].rstrip()
    put(name,old+'\n# scene-v2\n'+body)


def build():
    append('visual/context','execute store result storage magical_athlete:visual table int 1 run scoreboard players get @s ct_id')
    put('visual/refresh',[
        'function magical_athlete:visual/context',
        'execute as @e[tag=ma.event_prop] if score @s ct_id = #vis_table ma_ctx run kill @s',
        'scoreboard players set @s ma_vtimer 0','scoreboard players set @s ma_vframe 0',
        'execute as @e[tag=ma.racer] if score @s ct_id = #vis_table ma_ctx run tag @s add ma.outdated',
        'execute as @e[tag=ma.racer_name] if score @s ct_id = #vis_table ma_ctx run tag @s add ma.outdated',
        'data modify storage magical_athlete:visual track set value "mild"',
        'execute if data entity @s data.magical_athlete{track:1} run data modify storage magical_athlete:visual track set value "wild"',
        'function magical_athlete:visual/board_sync with storage magical_athlete:visual',
        'function magical_athlete:visual/dice_sync with storage magical_athlete:visual',
        'function magical_athlete:visual/dice_restore',
        *[f'execute if data entity @s data.magical_athlete.racers[{i}] run function magical_athlete:visual/racer_spawn {{index:{i}}}' for i in range(6)],
        'execute as @e[tag=ma.outdated] if score @s ct_id = #vis_table ma_ctx run kill @s',
        'function magical_athlete:direct/board_refresh','function magical_athlete:visual/info_update'])
    put('visual/board_sync',[
        '$execute as @e[tag=ma.board,scores={ct_id=$(table)}] run function magical_athlete:visual/board_init with storage magical_athlete:visual',
        '$execute unless entity @e[tag=ma.board,scores={ct_id=$(table)}] run function magical_athlete:visual/board_spawn with storage magical_athlete:visual'])
    put('visual/dice_sync',[
        '$execute unless entity @e[tag=ma.die,scores={ct_id=$(table)}] run function magical_athlete:visual/dice_spawn'])
    put('visual/racer_spawn',[
        '$data modify storage magical_athlete:visual racer set from entity @s data.magical_athlete.racers[$(index)]',
        'execute if data storage magical_athlete:visual racer{char:-1} run return 0',
        'execute if data storage magical_athlete:visual racer{owner:0} run return 0',
        '$data modify storage magical_athlete:visual racer.index set value $(index)',
        'function magical_athlete:visual/racer_data with storage magical_athlete:visual racer',
        'data modify storage magical_athlete:visual pose.duration set value 2',
        'function magical_athlete:visual/racer_sync with storage magical_athlete:visual',
        'execute if score @s ma_state matches 3..5 run function magical_athlete:visual/name_spawn with storage magical_athlete:visual racer'])
    put('visual/racer_sync',[
        'scoreboard players set #racer_exists ma_ctx 0',
        '$execute if entity @e[tag=ma.racer,scores={ct_id=$(table),ma_vid=$(index)}] run scoreboard players set #racer_exists ma_ctx 1',
        '$execute if score #racer_exists ma_ctx matches 1 as @e[tag=ma.racer,scores={ct_id=$(table),ma_vid=$(index)}] run function magical_athlete:visual/racer_init with storage magical_athlete:visual',
        'execute if score #racer_exists ma_ctx matches 0 positioned ~ ~1.04 ~ summon minecraft:item_display run function magical_athlete:visual/racer_init with storage magical_athlete:visual'])
    append('visual/racer_init','tag @s remove ma.outdated')
    put('visual/name_spawn',[
        '$data modify storage magical_athlete:visual owner_name set from entity @s data.magical_athlete.p$(owner).name',
        'function magical_athlete:visual/name_sync with storage magical_athlete:visual'])
    put('visual/name_sync',[
        'scoreboard players set #name_exists ma_ctx 0',
        '$execute if entity @e[tag=ma.racer_name,scores={ct_id=$(table),ma_vid=$(index)}] run scoreboard players set #name_exists ma_ctx 1',
        '$execute if score #name_exists ma_ctx matches 1 as @e[tag=ma.racer_name,scores={ct_id=$(table),ma_vid=$(index)}] run function magical_athlete:visual/name_init with storage magical_athlete:visual',
        'execute if score #name_exists ma_ctx matches 0 positioned ~ ~1.04 ~ summon minecraft:text_display run function magical_athlete:visual/name_init with storage magical_athlete:visual'])
    append('visual/name_init','tag @s remove ma.outdated')
    # 以千分之一格计算路径进度，在相邻格心之间插值；转角仍沿赛道走。
    put('visual/move_frame',[
        '$scoreboard players set #v_from ma_ctx $(from)','$scoreboard players set #v_to ma_ctx $(to)',
        'scoreboard players set #v_unit ma_ctx 1000',
        'scoreboard players operation #v_progress ma_ctx = #v_to ma_ctx',
        'scoreboard players operation #v_progress ma_ctx -= #v_from ma_ctx',
        'scoreboard players operation #v_progress ma_ctx *= #v_unit ma_ctx',
        'scoreboard players operation #v_progress ma_ctx *= @s ma_vframe',
        'scoreboard players set #v_duration ma_ctx 12',
        'execute if score @s ma_speed matches 1 run scoreboard players set #v_duration ma_ctx 6',
        'scoreboard players operation #v_progress ma_ctx /= #v_duration ma_ctx',
        'scoreboard players operation #v_from ma_ctx *= #v_unit ma_ctx',
        'scoreboard players operation #v_progress ma_ctx += #v_from ma_ctx',
        'execute if score #v_progress ma_ctx matches ..-1 run scoreboard players set #v_progress ma_ctx 0',
        'execute if score #v_progress ma_ctx matches 30001.. run scoreboard players set #v_progress ma_ctx 30000',
        'scoreboard players operation #v_cell ma_ctx = #v_progress ma_ctx',
        'scoreboard players operation #v_cell ma_ctx /= #v_unit ma_ctx',
        'scoreboard players operation #v_fraction ma_ctx = #v_progress ma_ctx',
        'scoreboard players operation #v_fraction ma_ctx %= #v_unit ma_ctx',
        'scoreboard players operation #v_next ma_ctx = #v_cell ma_ctx','scoreboard players add #v_next ma_ctx 1',
        'execute if score #v_next ma_ctx matches 31.. run scoreboard players set #v_next ma_ctx 30',
        'execute store result storage magical_athlete:visual position int 1 run scoreboard players get #v_cell ma_ctx',
        'execute store result storage magical_athlete:visual next int 1 run scoreboard players get #v_next ma_ctx',
        '$data modify storage magical_athlete:visual pawn set value $(pawn)',
        'function magical_athlete:visual/move_fraction with storage magical_athlete:visual'])
    lerp=['$data modify storage magical_athlete:visual pose set from storage magical_athlete:visual layout.pawns[$(pawn)][$(position)]',
        '$data modify storage magical_athlete:visual next_pose set from storage magical_athlete:visual layout.pawns[$(pawn)][$(next)]']
    for axis in ('x','z'):
        lerp += [f'execute store result score #v_a ma_ctx run data get storage magical_athlete:visual pose.{axis} 1000000',
            f'execute store result score #v_b ma_ctx run data get storage magical_athlete:visual next_pose.{axis} 1000000',
            'scoreboard players operation #v_b ma_ctx -= #v_a ma_ctx',
            'scoreboard players operation #v_b ma_ctx *= #v_fraction ma_ctx',
            'scoreboard players operation #v_b ma_ctx /= #v_unit ma_ctx',
            'scoreboard players operation #v_a ma_ctx += #v_b ma_ctx',
            f'execute store result storage magical_athlete:visual pose.{axis} double 0.000001 run scoreboard players get #v_a ma_ctx']
    lerp += ['data modify storage magical_athlete:visual pose.duration set value 2',
        '$execute as @e[tag=ma.racer,scores={ma_vid=$(pawn)}] if score @s ct_id = #vis_table ma_ctx run function magical_athlete:visual/racer_pose with storage magical_athlete:visual pose']
    put('visual/move_fraction',lerp)
    info()
    pool()


def info():
    put('visual/info_update',[
        'execute unless score @s ct_state matches 1 run return 0','function magical_athlete:visual/context',
        'data modify storage magical_athlete:visual info set value {text:"胡闹运动会",color:"gold",extra:[]}',
        'function magical_athlete:visual/info_round with entity @s data.magical_athlete',
        'scoreboard players set #info_actor ma_ctx 0',
        'execute if score @s ma_state matches 1 run scoreboard players operation #info_actor ma_ctx = @s ma_turn',
        'execute if score @s ma_state matches 3 run scoreboard players operation #info_actor ma_ctx = @s ma_turn',
        'execute if score @s ma_pending matches 1.. run scoreboard players operation #info_actor ma_ctx = @s ma_pending',
        'execute if score @s ma_anim matches 1.. store result score #info_actor ma_ctx run data get entity @s data.ma_feedback.last_actor',
        *[f'execute if data entity @s data.magical_athlete.p{i}.name run function magical_athlete:visual/info_row {{side:{i}}}' for i in range(1,7)],
        'function magical_athlete:visual/info_sync with storage magical_athlete:visual'])
    put('visual/info_round',r'$data modify storage magical_athlete:visual info.extra append value {text:" · 第$(round)/4场\n",color:"gold"}')
    put('visual/info_row',[
        '$data modify storage magical_athlete:visual info.extra append from entity @s data.magical_athlete.p$(side).name',
        '$execute if score #info_actor ma_ctx matches $(side) run data modify storage magical_athlete:visual info.extra append value {text:" ▶",color:"yellow"}',
        'data modify storage magical_athlete:visual info.extra append value {text:" · ",color:"gray"}',
        '$data modify storage magical_athlete:visual info_player set from entity @s data.magical_athlete.p$(side)',
        'function magical_athlete:visual/info_points with storage magical_athlete:visual info_player',
        'execute if score @s ma_state matches 2 run data modify storage magical_athlete:visual info.extra append value {text:" · 秘密阵容",color:"gray"}',
        *[f'$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {{index:{i},side:$(side)}}' for i in range(6)],
        r'data modify storage magical_athlete:visual info.extra append value {text:"\n"}'])
    put('visual/info_points','$data modify storage magical_athlete:visual info.extra append value {text:"$(points)分（本场$(race_points)）",color:"white"}')
    put('visual/info_racer',[
        '$data modify storage magical_athlete:visual info_racer set from entity @s data.magical_athlete.racers[$(index)]',
        '$execute unless data storage magical_athlete:visual info_racer{owner:$(side)} run return 0',
        'execute if data storage magical_athlete:visual info_racer{char:-1} run return 0',
        'function magical_athlete:visual/info_racer_name with storage magical_athlete:visual info_racer'])
    put('visual/info_racer_name',[
        '$data modify storage magical_athlete:visual info_name set from storage magical_athlete:characters chars[$(char)].name',
        'data modify storage magical_athlete:visual info.extra append value {text:" · ",color:"gray"}',
        'function magical_athlete:visual/info_racer_text with storage magical_athlete:visual'])
    put('visual/info_racer_text','$data modify storage magical_athlete:visual info.extra append value {text:"$(info_name)",color:"aqua"}')
    put('visual/info_sync',[
        '$execute unless entity @e[tag=ma.table_info,scores={ct_id=$(table)}] positioned ~ ~1.79 ~ summon minecraft:text_display run function magical_athlete:visual/info_init',
        '$execute as @e[tag=ma.table_info,scores={ct_id=$(table)}] run data modify entity @s text set from storage magical_athlete:visual info'])
    put('visual/info_init',[
        'tag @s add ma.visual','tag @s add ma.table_info','scoreboard players operation @s ct_id = #vis_table ma_ctx',
        'data merge entity @s {billboard:"vertical",alignment:"center",background:0,shadow:1b,see_through:0b,line_width:400,view_range:1.0f,brightness:{block:15,sky:15},transformation:{scale:[0.28f,0.28f,0.28f]}}'])
    append('game/hud','function magical_athlete:visual/info_update')


def pool():
    put('direct/board_refresh',[
        'scoreboard players operation #table ma_ctx = @s ct_id',
        'execute as @e[tag=ma.hit] if score @s ct_id = #table ma_ctx run kill @s',
        'execute as @e[tag=ma.cell_preview] if score @s ct_id = #table ma_ctx run kill @s',
        'execute as @e[tag=ma.pool] if score @s ct_id = #table ma_ctx run tag @s add ma.outdated',
        'execute as @e[tag=ma.pool_title] if score @s ct_id = #table ma_ctx run tag @s add ma.outdated',
        'function magical_athlete:visual/context',
        'execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ct_id',
        'execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_epoch',
        'execute if score @s ma_state matches 1 run function magical_athlete:direct/pool_spawn',
        'execute as @e[tag=ma.outdated] if score @s ct_id = #table ma_ctx run kill @s',
        'execute if score @s ma_state matches 3 run function magical_athlete:direct/racer_hits'])
    path=ROOT/'direct/pool_data.mcfunction'
    body=path.read_text(encoding='utf-8').splitlines()
    put('direct/pool_data',[line for line in body if 'execute positioned ' not in line]+['function magical_athlete:direct/pool_place with storage magical_athlete:direct'])
    put('direct/pool_place',[
        '$execute unless entity @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] positioned ~$(x) ~1.055 ~$(z) summon minecraft:item_display run function magical_athlete:direct/pool_init with storage magical_athlete:direct',
        '$execute as @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] run tag @s remove ma.outdated',
        '$execute as @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] run data merge entity @s {teleport_duration:3}',
        '$execute as @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] run tp @s ~$(x) ~1.055 ~$(z)',
        '$execute positioned ~$(x) ~1.055 ~$(z) summon minecraft:interaction run function magical_athlete:direct/hit_init with storage magical_athlete:direct',
        '$execute unless entity @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] positioned ~$(x) ~1.42 ~$(z) summon minecraft:text_display run function magical_athlete:direct/pool_title with storage magical_athlete:direct',
        '$execute as @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] run tag @s remove ma.outdated',
        '$execute as @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] run data merge entity @s {teleport_duration:3}',
        '$execute as @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] run tp @s ~$(x) ~1.42 ~$(z)'])
    append('direct/pool_title','tag @s add ma.pool_title\n$scoreboard players set @s ma_did $(id)')


if __name__=='__main__':build()
