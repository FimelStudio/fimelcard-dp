"""璀璨宝石转盘、公开市场、选择提示与十刻飞行动画。"""
from __future__ import annotations

import json
import math
from boardgame_assets import PACK, text_file

ROOT = PACK/'data/splendor/function/visual'
OBJECTIVES = {name: 'dummy' for name in ('sp_vid', 'sp_vkind', 'sp_vtimer', 'sp_vstep')}
COLORS = ('diamond', 'sapphire', 'emerald', 'ruby', 'onyx', 'gold')


def js(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def put(name, body):
    text_file(ROOT/(name+'.mcfunction'), '\n'.join(body) if isinstance(body, list) else body)


def pose(x=0, z=0, scale=1, y=0.025, yaw=0):
    angle = math.radians(yaw)
    return {'x': round(x*math.cos(angle)-z*math.sin(angle), 6),
            'y': round(y, 6), 'z': round(x*math.sin(angle)+z*math.cos(angle), 6),
            'scale': round(scale, 6), 'qy': round(-math.sin(angle/2), 7),
            'qw': round(math.cos(angle/2), 7), 'yaw': yaw,
            'gqx': round(math.cos(angle/2)*math.sqrt(.5), 7),
            'gqy': round(-math.sin(angle/2)*math.sqrt(.5), 7),
            'gqz': round(math.sin(angle/2)*math.sqrt(.5), 7),
            'gqw': round(math.cos(angle/2)*math.sqrt(.5), 7)}


def build():
    load = [f'scoreboard objectives add {key} {kind}' for key, kind in OBJECTIVES.items()]
    for capacity, factor in ((4, 1.0), (8, 1.28)):
        for seat in range(1, capacity+1):
            side = seat if capacity == 4 else (seat+1)//2
            yaw = {1: 180, 2: 270, 3: 0, 4: 90}[side]
            def p(x=0, z=0, scale=1, y=.025):
                return pose(x, z, scale, y, yaw)
            # 牌面下沿和银行靠近当前玩家；一级牌最近、三级牌最远。
            slots = [p((-.703125+col*.46875)*factor, (-.6875+row*.6484375)*factor,
                       .44*factor) for row in range(3) for col in range(4)]
            slots = slots[8:12]+slots[4:8]+slots[0:4]
            nobles = [p((i-2)*.43*factor, -1.10*factor, .34*factor) for i in range(5)]
            bank = [p((i-2.5)*.42*factor, 1.15*factor, .28*factor, .03) for i in range(6)]
            decks = [p(-1.17*factor, (.609375-(tier-1)*.6484375)*factor, .33*factor)
                     for tier in range(1, 4)]
            deck_labels = [p(-1.03*factor, (.409375-(tier-1)*.6484375)*factor,
                             .20, .15) for tier in range(1, 4)]
            free_labels = [p((-.703125+col*.46875)*factor,
                             (-.6875+row*.6484375-.22)*factor, .14, .12)
                           for row in range(3) for col in range(4)]
            free_labels = free_labels[8:12]+free_labels[4:8]+free_labels[0:4]
            gem_labels = [p((i-2.5)*.42*factor, 1.15*factor, .22, .27) for i in range(6)]
            layout = {'slots': slots, 'nobles': nobles, 'bank': bank, 'decks': decks,
                      'deck_labels': deck_labels, 'free_labels': free_labels,
                      'gem_labels': gem_labels, 'mat': p(scale=3*factor, y=.0)}
            load += [f'data modify storage splendor:layout c{capacity}s{seat} set value '+js(layout)]
    put('load', load)
    put('context', ['execute unless data storage splendor:layout c8s1.slots run function splendor:visual/load',
        'scoreboard players operation #vis_table sp_ctx = @s ct_id',
        'data modify storage splendor:visual layout set value "c4s3"',
        'data modify storage splendor:visual bonus set value [0,0,0,0,0]',
        'execute if score @s ct_capacity matches 8 run data modify storage splendor:visual layout set value "c8s5"',
        'execute if data entity @s data.splendor.turn run function splendor:visual/orientation with entity @s data.splendor'])
    put('orientation', ['$execute if data entity @s data.splendor.p$(turn).seat run function splendor:visual/read_seat {seat:0,turn:$(turn)}',
        '$data modify storage splendor:visual bonus set from entity @s data.splendor.p$(turn).bonus'])
    put('read_seat', ['$data modify storage splendor:visual seat set from entity @s data.splendor.p$(turn).seat',
        'data modify storage splendor:visual capacity set value 4',
        'execute if score @s ct_capacity matches 8 run data modify storage splendor:visual capacity set value 8',
        'function splendor:visual/seat_layout with storage splendor:visual'])
    put('seat_layout', '$data modify storage splendor:visual layout set value "c$(capacity)s$(seat)"')
    put('clear', ['function splendor:visual/context',
        'execute as @e[tag=sp.visual] if score @s sp_table = #vis_table sp_ctx run kill @s',
        'scoreboard players set @s sp_vtimer 0', 'scoreboard players set @s sp_vstep 0',
        'data remove entity @s data.splendor.visual_active'])
    put('preview', 'function splendor:visual/refresh')
    put('refresh', ['# 仅清表现；不改变牌库、预约、last、回合或已提交的支付。',
        'function splendor:visual/clear', 'execute at @s run function splendor:visual/refresh_at'])
    put('refresh_at', ['data modify storage splendor:visual model set value "mat"',
        'data modify storage splendor:visual kind set value 1', 'data modify storage splendor:visual id set value 0',
        'function splendor:visual/mat with storage splendor:visual',
        *[f'function splendor:visual/market {{slot:{i}}}' for i in range(12)],
        *[f'function splendor:visual/noble {{slot:{i}}}' for i in range(5)],
        *[f'function splendor:visual/bank {{slot:{i},model:"token/{name}"}}' for i, name in enumerate(COLORS)],
        *[f'function splendor:visual/deck {{slot:{i-1},tier:{i}}}' for i in range(1, 4)],
        'function splendor:visual/selection'])
    put('mat', ['$data modify storage splendor:visual pose set from storage splendor:layout $(layout).mat',
        'function splendor:visual/spawn'])
    put('market', ['$data modify storage splendor:visual card set from entity @s data.splendor.market[$(slot)]',
        'execute if data storage splendor:visual {card:-1} run return 0',
        '$data modify storage splendor:visual slot set value $(slot)',
        'data modify storage splendor:visual kind set value 2',
        '$data modify storage splendor:visual id set value $(slot)',
        'function splendor:visual/card_model with storage splendor:visual',
        'function splendor:visual/card_pose with storage splendor:visual',
        'function splendor:visual/spawn',
        'function splendor:visual/free_check with storage splendor:visual'])
    put('card_model', '$data modify storage splendor:visual model set from storage splendor:cards cards[$(card)].name')
    put('card_pose', '$data modify storage splendor:visual pose set from storage splendor:layout $(layout).slots[$(slot)]')
    put('noble', ['$data modify storage splendor:visual noble set from entity @s data.splendor.nobles[$(slot)]',
        'execute if data storage splendor:visual {noble:-1} run return 0',
        '$data modify storage splendor:visual slot set value $(slot)',
        'data modify storage splendor:visual kind set value 3',
        '$data modify storage splendor:visual id set value $(slot)',
        'function splendor:visual/noble_model with storage splendor:visual',
        'function splendor:visual/noble_pose with storage splendor:visual',
        'function splendor:visual/spawn'])
    put('noble_model', ['$data modify storage splendor:visual noble_name set from storage splendor:cards nobles[$(noble)].name',
        'function splendor:visual/noble_name with storage splendor:visual'])
    put('noble_name', '$data modify storage splendor:visual model set value "noble/$(noble_name)"')
    put('noble_pose', '$data modify storage splendor:visual pose set from storage splendor:layout $(layout).nobles[$(slot)]')
    put('bank', ['$data modify storage splendor:visual count set from entity @s data.splendor.bank[$(slot)]',
        '$data modify storage splendor:visual model set value "$(model)"',
        '$data modify storage splendor:visual slot set value $(slot)',
        'data modify storage splendor:visual kind set value 4',
        '$data modify storage splendor:visual id set value $(slot)',
        'function splendor:visual/bank_pose with storage splendor:visual',
        'function splendor:visual/spawn',
        'function splendor:visual/gem_count with storage splendor:visual'])
    put('bank_pose', '$data modify storage splendor:visual pose set from storage splendor:layout $(layout).bank[$(slot)]')
    put('deck', [
        '$data modify storage splendor:visual model set value "back/tier$(tier)"',
        '$data modify storage splendor:visual slot set value $(slot)',
        'data modify storage splendor:visual kind set value 5',
        '$data modify storage splendor:visual id set value $(slot)',
        'function splendor:visual/deck_pose with storage splendor:visual', 'function splendor:visual/spawn',
        '$execute store result storage splendor:visual count int 1 run data get entity @s data.splendor.deck$(tier)',
        'function splendor:visual/deck_count with storage splendor:visual'])
    put('deck_pose', '$data modify storage splendor:visual pose set from storage splendor:layout $(layout).decks[$(slot)]')
    put('spawn', 'execute positioned ~ ~1.045 ~ summon minecraft:item_display run function splendor:visual/init with storage splendor:visual')
    put('init', ['tag @s add sp.visual', 'scoreboard players operation @s sp_table = #vis_table sp_ctx',
        'scoreboard players operation @s ct_id = #vis_table sp_ctx',
        '$scoreboard players set @s sp_vid $(id)', '$scoreboard players set @s sp_vkind $(kind)',
        '$data merge entity @s {item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"card:splendor/$(model)"}},item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:0.5f}',
        'function splendor:visual/pose with storage splendor:visual pose',
        'execute if score @s sp_vkind matches 2..5 run function splendor:direct/spawn with storage splendor:visual pose'])
    # 与卡坦岛一致，抵消 none 渲染上下文自带的 Y180，牌槽和绘图使用同一坐标。
    put('pose', '$data merge entity @s {transformation:{translation:[$(x)f,$(y)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f],left_rotation:[0f,$(qy)f,0f,$(qw)f],right_rotation:[0f,1f,0f,0f]}}')
    build_labels()
    build_selection()
    for obsolete in ('counts', 'counts_layout', 'counts_at'):
        put(obsolete, 'return 0')
    # 规则提交后保存事件快照，身份未公开的预约动作只用中性宝石袋表现。
    put('animate', ['execute if score @s ct_paused matches 1 run return 0',
        'function splendor:visual/context',
        'data modify entity @s data.splendor.visual_active set from entity @s data.splendor.last',
        'data modify storage splendor:visual event set from entity @s data.splendor.visual_active',
        'execute if data storage splendor:visual event{actor:0} run return 0',
        'function splendor:visual/actor with storage splendor:visual event',
        'data modify entity @s data.splendor.visual_active.seat set from storage splendor:visual seat',
        'function cardtable:chairs/layout/position with storage splendor:visual',
        'data modify storage splendor:visual end set from storage cardtable:layout position',
        'function splendor:visual/build_motion',
        'data modify storage splendor:visual model set value "bag"',
        'execute if data storage splendor:visual event{code:3} run function splendor:visual/bought_card',
        'execute if data storage splendor:visual event{code:5} run function splendor:visual/arriving_noble',
        'execute if data storage splendor:visual event{code:1} run function splendor:visual/take_tokens',
        'execute if data storage splendor:visual event{code:4} run function splendor:visual/return_tokens',
        'data modify storage splendor:visual kind set value 9',
        'data modify storage splendor:visual id set value 0',
        'data modify storage splendor:visual pose set from entity @s data.splendor.visual_active.motion[0]',
        'function splendor:visual/spawn',
        'scoreboard players set #vis_noble sp_ctx -1',
        'execute store result score #vis_noble sp_ctx run data get storage splendor:visual event.noble',
        'execute if score #vis_noble sp_ctx matches 0..9 unless data storage splendor:visual event{code:5} run function splendor:visual/noble_bonus',
        'execute as @e[tag=sp.visual,scores={sp_vkind=9}] if score @s sp_table = #vis_table sp_ctx run tag @s add sp.anim',
        'scoreboard players set @s sp_vtimer 10', 'scoreboard players set @s sp_vstep 0'])
    put('actor', '$data modify storage splendor:visual seat set from entity @s data.splendor.p$(actor).seat')
    put('bought_card', ['data modify storage splendor:visual card set from storage splendor:visual event.card',
        'function splendor:visual/card_model with storage splendor:visual'])
    put('arriving_noble', ['data modify storage splendor:visual noble set from storage splendor:visual event.noble',
        'function splendor:visual/noble_model with storage splendor:visual'])
    put('noble_bonus', ['function splendor:visual/arriving_noble',
        'data modify storage splendor:visual id set value 1',
        'function splendor:visual/spawn',
        'execute at @s run particle minecraft:happy_villager ~ ~1.4 ~ .30 .12 .30 .03 15 force'])
    # 多色拿珠可由公开take字段选一个代表色，避免一回合生成大量额外实体。
    put('take_tokens', [f'execute store result score #vis_count sp_ctx run data get storage splendor:visual event.take[{i}]\nexecute if score #vis_count sp_ctx matches 1.. run data modify storage splendor:visual model set value "token/{name}"' for i, name in enumerate(COLORS)])
    put('return_tokens', 'function splendor:visual/take_tokens')
    # 实际座椅坐标乘0.6置于桌边；不假定八人桌一定成对留椅。
    motion = ['data modify entity @s data.splendor.visual_active.motion set value []']
    for step in range(1, 11):
        t = step/10
        eased = t*t*(3-2*t)
        motion += ['data modify storage splendor:visual frame set value '+js(pose(y=round(.08+.72*4*t*(1-t), 6), scale=.30)),
            'execute store result score #vis_x sp_ctx run data get storage splendor:visual end.x 100000',
            'execute store result score #vis_z sp_ctx run data get storage splendor:visual end.z 100000',
            f'scoreboard players set #vis_mul sp_ctx {round(.6*eased*10000)}',
            f'execute if data storage splendor:visual event{{code:4}} run scoreboard players set #vis_mul sp_ctx {round(.6*(1-eased)*10000)}',
            'scoreboard players set #vis_div sp_ctx 10000',
            'scoreboard players operation #vis_x sp_ctx *= #vis_mul sp_ctx',
            'scoreboard players operation #vis_z sp_ctx *= #vis_mul sp_ctx',
            'scoreboard players operation #vis_x sp_ctx /= #vis_div sp_ctx',
            'scoreboard players operation #vis_z sp_ctx /= #vis_div sp_ctx',
            'execute store result storage splendor:visual frame.x double 0.00001 run scoreboard players get #vis_x sp_ctx',
            'execute store result storage splendor:visual frame.z double 0.00001 run scoreboard players get #vis_z sp_ctx',
            'data modify entity @s data.splendor.visual_active.motion append from storage splendor:visual frame']
    put('build_motion', motion)
    put('tick', ['execute if score @s ct_paused matches 1 run return 0',
        'execute unless score @s sp_vtimer matches 1.. run return 0',
        'function splendor:visual/context',
        'execute store result storage splendor:visual step int 1 run scoreboard players get @s sp_vstep',
        'function splendor:visual/read_frame with storage splendor:visual',
        'execute as @e[tag=sp.anim] if score @s sp_table = #vis_table sp_ctx run function splendor:visual/animate_frame with storage splendor:visual frame',
        'scoreboard players add @s sp_vstep 1', 'scoreboard players remove @s sp_vtimer 1',
        'execute if score @s sp_vtimer matches 0 run function splendor:visual/animation_done'])
    put('read_frame', '$data modify storage splendor:visual frame set from entity @s data.splendor.visual_active.motion[$(step)]')
    put('animate_frame', ['$data merge entity @s {start_interpolation:0,interpolation_duration:1,transformation:{translation:[$(x)f,$(y)f,$(z)f],scale:[$(scale)f,$(scale)f,$(scale)f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,1f,0f,0f]}}',
        'execute if score @s sp_vid matches 1 run function splendor:visual/noble_flight_offset'])
    put('noble_flight_offset', ['execute store result score #vis_flight_y sp_ctx run data get entity @s transformation.translation[1] 100000',
        'scoreboard players add #vis_flight_y sp_ctx 12000',
        'execute store result entity @s transformation.translation[1] float 0.00001 run scoreboard players get #vis_flight_y sp_ctx'])
    put('animation_done', ['execute as @e[tag=sp.anim] if score @s sp_table = #vis_table sp_ctx run kill @s',
        'data remove entity @s data.splendor.visual_active',
        'execute at @s run particle minecraft:enchant ~ ~1.15 ~ .40 .05 .40 0.02 10 force'])


def build_labels():
    put('free_check', ['scoreboard players set #vis_free sp_ctx 1']+[
        f'$execute store result score #vis_cost sp_ctx run data get storage splendor:cards cards[$(card)].cost[{i}]\n'
        f'execute store result score #vis_bonus sp_ctx run data get storage splendor:visual bonus[{i}]\n'
        'execute if score #vis_cost sp_ctx > #vis_bonus sp_ctx run scoreboard players set #vis_free sp_ctx 0'
        for i in range(5)]+[
        'execute unless score #vis_free sp_ctx matches 1 run return 0',
        '$data modify storage splendor:visual pose set from storage splendor:layout $(layout).free_labels[$(slot)]',
        'data modify storage splendor:visual kind set value 7',
        'data modify storage splendor:visual text set value {text:"免费",color:"green",bold:true}',
        'function splendor:visual/label_spawn'])
    for name, poses, kind in (('gem_count', 'gem_labels', 10), ('deck_count', 'deck_labels', 8)):
        put(name, [f'$data modify storage splendor:visual pose set from storage splendor:layout $(layout).{poses}[$(slot)]',
            f'data modify storage splendor:visual kind set value {kind}',
            '$data modify storage splendor:visual text set value {text:"$(count)",color:"gold",bold:true}',
            'function splendor:visual/label_spawn'])
    put('label_spawn', 'execute positioned ~ ~1.045 ~ run function splendor:visual/label_at with storage splendor:visual pose')
    put('label_at', '$execute positioned ~$(x) ~$(y) ~$(z) summon minecraft:text_display run function splendor:visual/label_init with storage splendor:visual')
    put('label_init', ['tag @s add sp.visual', 'tag @s add sp.label',
        'scoreboard players operation @s sp_table = #vis_table sp_ctx',
        'scoreboard players operation @s ct_id = #vis_table sp_ctx',
        '$scoreboard players set @s sp_vid $(id)', '$scoreboard players set @s sp_vkind $(kind)',
        '$data merge entity @s {text:$(text),billboard:"vertical",Rotation:[0f,0f],background:0,shadow:1b,see_through:0b,view_range:0.7f,line_width:80}',
        'function splendor:visual/label_pose with storage splendor:visual pose'])
    put('label_pose', '$data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[$(scale)f,$(scale)f,$(scale)f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}')


def build_selection():
    put('selection', ['scoreboard players operation #vis_table sp_ctx = @s ct_id',
        'scoreboard players set #vis_turn sp_ctx 0',
        'scoreboard players set #vis_epoch sp_ctx -1',
        'execute store result score #vis_turn sp_ctx run data get entity @s data.splendor.turn',
        'execute store result score #vis_epoch sp_ctx run data get entity @s data.splendor.epoch',
        'execute as @e[type=minecraft:item_display,tag=sp.selected] if score @s sp_table = #vis_table sp_ctx run data merge entity @s {Glowing:0b}',
        'execute as @e[tag=sp.selected] if score @s sp_table = #vis_table sp_ctx run tag @s remove sp.selected',
        'execute if score @s sp_state matches 3 run function splendor:visual/eligible_nobles',
        'execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #vis_table sp_ctx if score @s ct_id = #vis_table sp_ctx if score @s sp_side = #vis_turn sp_ctx if score @s sp_select_epoch = #vis_epoch sp_ctx run function splendor:visual/selection_player'])
    put('selection_player', ['scoreboard players operation #vis_id sp_ctx = @s sp_select_id',
        'scoreboard players operation #vis_kind sp_ctx = @s sp_select_kind',
        'execute if score #vis_kind sp_ctx matches 2..5 run function splendor:visual/highlight',
        *[f'execute if score @s sp_pick{i} matches 1.. run function splendor:visual/highlight_gem {{id:{i}}}' for i in range(6)]])
    put('highlight_gem', ['scoreboard players set #vis_kind sp_ctx 4',
        '$scoreboard players set #vis_id sp_ctx $(id)',
        'function splendor:visual/highlight'])
    put('highlight', ['execute as @e[type=minecraft:item_display,tag=sp.visual] if score @s sp_table = #vis_table sp_ctx if score @s sp_vkind = #vis_kind sp_ctx if score @s sp_vid = #vis_id sp_ctx run tag @s add sp.selected',
        'execute as @e[type=minecraft:item_display,tag=sp.selected] if score @s sp_table = #vis_table sp_ctx run data merge entity @s {Glowing:1b,glow_color_override:16766720}'])
    put('eligible_nobles', ['scoreboard players set #vis_kind sp_ctx 3']+[
        f'execute if data entity @s data.splendor{{eligible:[{i}]}} run function splendor:visual/eligible_noble {{id:{i}}}' for i in range(5)])
    put('eligible_noble', ['$scoreboard players set #vis_id sp_ctx $(id)',
        'function splendor:visual/highlight'])


if __name__ == '__main__':
    build()
