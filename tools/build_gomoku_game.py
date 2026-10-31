"""生成五子棋生命周期、计时及通用牌桌接入外的游戏函数。

规则/UI/模型分别由 build_gomoku_engine/ui/visual.py 维护。运行本脚本只更新
gomoku 的 load/tick/system/game/player/admin/clock/log，不重写其他模块。
"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / 'data/gomoku/function'


def put(name, lines):
    target = ROOT / (name + '.mcfunction')
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')


def say(text, target='@a[tag=gm.audience]', color='yellow'):
    return 'tellraw ' + target + ' ' + json.dumps({'text': '[五子棋] ' + text, 'color': color}, ensure_ascii=False)


def main():
    dummy = """gm_ctx gm_state gm_sq gm_file gm_rank gm_piece gm_turn gm_moves gm_last
gm_epoch gm_result gm_reason gm_sel gm_timer gm_black gm_white gm_table gm_side gm_seat
gm_weight gm_btime gm_wtime gm_board gm_palette gm_orient gm_time gm_draw gm_pulse
gm_seen gm_ui_load gm_ui_tmp gm_set_table gm_setnonce gm_setepoch gm_nonce gm_first gm_undo
gm_bot gm_level gm_size gm_mark gm_coords gm_confirm gm_aistate gm_aiwait gm_aiepoch
gm_animundo gm_coordnonce gm_coordepoch gm_coordload gm_coordtable""".split()
    put('system/install', [f'scoreboard objectives add {o} dummy' for o in dummy if o != 'gm_ctx'] + [
        'scoreboard objectives add gm_action trigger', 'scoreboard objectives add gm_settings trigger', 'scoreboard objectives add gm_coord trigger',
        'scoreboard objectives add gm_drop minecraft.dropped:minecraft.paper',
        'scoreboard players set #version gm_ctx 1'])


    put('load', '''
scoreboard objectives add gm_ctx dummy
execute unless score #version gm_ctx matches 1.. run function gomoku:system/install
# gm_first 已改为 0 随机黑白、1 按棋盘边自行选边；旧指定座位值不再有效。
execute as @e[tag=gm.controller] unless score @s gm_first matches 0..1 run scoreboard players set @s gm_first 0
function gomoku:visual/load
scoreboard players set #nineteen gm_ctx 19
scoreboard players set #minus gm_ctx -1
scoreboard players set #two gm_ctx 2
scoreboard players set #four gm_ctx 4
scoreboard players set #eight gm_ctx 8
scoreboard players set #nine gm_ctx 9
scoreboard players set #ten gm_ctx 10
scoreboard players set #twenty gm_ctx 20
scoreboard players set #sixty gm_ctx 60
scoreboard players set #thousand gm_ctx 1000
execute unless score #setting_serial gm_ctx matches 100000..999999 run scoreboard players set #setting_serial gm_ctx 99999
scoreboard players add #ui_load gm_ctx 1
scoreboard players reset * gm_action
scoreboard players reset * gm_settings
scoreboard players reset * gm_setnonce
scoreboard players reset * gm_coord
scoreboard players reset * gm_coordnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14}] at @s run function gomoku:system/reload
''')
    put('system/context', '''
# 每个入口重新绑定桌号；规则/交互均不依赖“最近实体”。
scoreboard players operation #table gm_ctx = @s ct_id
tag @e[tag=gm.current] remove gm.current
tag @e[tag=gm.board] remove gm.board
tag @a[tag=gm.audience] remove gm.audience
tag @e[tag=gm.audience] remove gm.audience
tag @s add gm.current
execute as @e[type=minecraft:marker,tag=gm.square] if score @s ct_id = #table gm_ctx run tag @s add gm.board
execute as @e[tag=gm.player,tag=ct.player] if score @s gm_table = #table gm_ctx if score @s ct_id = #table gm_ctx run tag @s add gm.audience
''')
    put('game/init_table', '''
tag @s add gm.controller
execute unless score @s gm_board matches 0..1 run scoreboard players set @s gm_board 0
scoreboard players set @s gm_palette 0
execute unless score @s gm_orient matches 0..1 run scoreboard players set @s gm_orient 0
execute unless score @s gm_time matches 0..30 run scoreboard players set @s gm_time 10
execute unless score @s gm_first matches 0..1 run scoreboard players set @s gm_first 0
execute unless score @s gm_level matches 1..3 run scoreboard players set @s gm_level 2
execute unless score @s gm_size matches 13 unless score @s gm_size matches 15 unless score @s gm_size matches 19 run scoreboard players set @s gm_size 15
execute unless score @s gm_mark matches 0..1 run scoreboard players set @s gm_mark 1
execute unless score @s gm_coords matches 0..1 run scoreboard players set @s gm_coords 1
execute unless score @s gm_confirm matches 0..1 run scoreboard players set @s gm_confirm 0
execute unless score @s gm_bot matches -1..1 run scoreboard players set @s gm_bot 0
execute unless score @s gm_epoch matches 1.. run scoreboard players set @s gm_epoch 1
execute if score @s ct_state matches 0 run function gomoku:game/preview
''')
    put('system/create_board', [
        'function gomoku:system/context', 'kill @e[type=minecraft:marker,tag=gm.board]',
        'scoreboard players operation #size gm_ctx = @s gm_size',
    ] + [f'execute if score #size gm_ctx matches {max(sq % 19, sq // 19)+1}.. summon minecraft:marker run function gomoku:system/square {{sq:{sq},file:{sq%19},rank:{sq//19}}}' for sq in range(361)] + ['function gomoku:system/context'])
    put('system/square', """
tag @s add gm.square
scoreboard players operation @s ct_id = #table gm_ctx
$scoreboard players set @s gm_sq $(sq)
$scoreboard players set @s gm_file $(file)
$scoreboard players set @s gm_rank $(rank)
scoreboard players set @s gm_piece 0
""")
    put('game/preview', '''
# 选择游戏或改变外观后立即显示；绝不重置进行中的对局。
execute unless score @s ct_game matches 14 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.gomoku{review:1b} run return run function gomoku:game/review
tag @s add gm.controller
scoreboard players set @s gm_state 0
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_timer 0
scoreboard players set @s gm_pulse 0
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
scoreboard players set @s gm_animundo 0
scoreboard players set @s gm_bot 0
function gomoku:ai/reset
data remove entity @s data.gomoku.ai_undo
data remove entity @s data.gomoku.undo
data remove entity @s data.gomoku.pending_undo
scoreboard players add @s gm_epoch 1
function gomoku:visual/clear
function gomoku:system/create_board
function gomoku:engine/init_board
function gomoku:visual/setup
''')
    put('game/review', '''
# 大厅保留终局棋面；重载或修改配色只重建展示，不初始化规则局面。
execute unless score @s ct_game matches 14 run return 0
execute unless score @s ct_state matches 0 run return 0
function gomoku:system/context
scoreboard players set @s gm_state 0
scoreboard players set @s gm_sel -1
scoreboard players add @s gm_epoch 1
function gomoku:ai/reset
function gomoku:visual/refresh
''')
    put('system/reload', '''
tag @s add gm.controller
execute if score @s ct_state matches 0 run return run function gomoku:game/init_table
function gomoku:system/context
scoreboard players add @s gm_epoch 1
function gomoku:ai/reset
# 保留阵营，恢复对应桌边与通用座位身份；不重新随机或重置棋局。
function gomoku:game/reseat
# 棋面、重复判定历史和时钟均保留；重建的只是展示实体。
function gomoku:visual/refresh
function gomoku:clock/create
execute as @a[tag=gm.audience] run function gomoku:input/give
function gomoku:ui/refresh
''')
    put('game/start', [
        'function gomoku:game/init_table',
        'execute unless score @s ct_joined matches 1..2 run ' + say('五子棋支持一至两名玩家，单人自动匹配人机。', '@a[tag=ct.start_actor,limit=1]', 'black'),
        'execute unless score @s ct_joined matches 1..2 run return fail',
        'function gomoku:system/context', 'scoreboard players set #online gm_ctx 0', 'scoreboard players set #blocked gm_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx run scoreboard players add #online gm_ctx 1',
        *[f'execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx if items entity @s hotbar.{slot} * unless items entity @s hotbar.{slot} minecraft:paper[minecraft:custom_data~{{gomoku:{{tool:1b}}}}] run scoreboard players set #blocked gm_ctx 1' for slot in (8,)],
        'execute unless score #online gm_ctx = @s ct_joined run ' + say('入座的玩家都需要在线。', '@a[tag=ct.start_actor,limit=1]', 'black'),
        'execute unless score #online gm_ctx = @s ct_joined run return fail',
        'execute if score #blocked gm_ctx matches 1 run ' + say('请先清空快捷栏最后一格（第9格）。', '@a[tag=ct.start_actor,limit=1]', 'black'),
        'execute if score #blocked gm_ctx matches 1 run return fail',
        'function gomoku:system/side_seats',
        'scoreboard players set #black_ready gm_ctx 0',
        'scoreboard players set #white_ready gm_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx run function gomoku:player/seat_side',
        'execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx if score @s gm_weight matches 1 run scoreboard players add #black_ready gm_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx if score @s gm_weight matches -1 run scoreboard players add #white_ready gm_ctx 1',
        'execute if score @s gm_first matches 1 run function gomoku:game/check_sides',
        'execute if score @s gm_first matches 1 if score #side_ok gm_ctx matches 0 run function gomoku:game/seat_hint',
        'execute if score @s gm_first matches 1 if score #side_ok gm_ctx matches 0 run return fail',
        'execute as @a[tag=ct.player] if score @s ct_id = #table gm_ctx run function gomoku:player/init',
        'function gomoku:system/context', 'function gomoku:game/assign_sides', 'function gomoku:game/reseat',
        'function gomoku:ai/reset', 'data remove entity @s data.gomoku.ai_undo',
        'function gomoku:settings/invalidate_table',
        'data remove entity @s data.gomoku.review',
        'scoreboard players set @s gm_state 1', 'scoreboard players set @s gm_sel -1', 'scoreboard players set @s gm_animundo 0',
        'scoreboard players set @s gm_timer 0', 'scoreboard players set @s gm_pulse 0', 'scoreboard players set @s gm_draw 0',
        'scoreboard players add @s gm_epoch 1', 'function gomoku:engine/init_board', 'function gomoku:visual/setup',
        'scoreboard players operation @s gm_btime = @s gm_time',
        'scoreboard players set #minute gm_ctx 1200', 'scoreboard players operation @s gm_btime *= #minute gm_ctx',
        'scoreboard players operation @s gm_wtime = @s gm_btime',
        'execute as @a[tag=gm.audience] run function gomoku:input/give',
        'scoreboard players set @s ct_start 1', 'function gomoku:clock/create', 'function gomoku:ui/refresh',
        'function gomoku:sound/start',
        say('黑方先行。右键交点落子，手持最后一格的对局菜单按 Q。'),
        'function gomoku:game/announce_sides',
        'function gomoku:log {text:"对局开始"}',
    ])
    put('player/init', '''
tag @s add gm.player
scoreboard players operation @s gm_table = @s ct_id
scoreboard players operation @s gm_seat = @s ct_seat
scoreboard players set @s gm_side -1
scoreboard players set @s gm_seen -1
''')
    # 黑方始终先行；这里只决定谁执黑，阵营再决定实际座位。
    put('game/check_sides', '''
scoreboard players set #side_ok gm_ctx 0
execute if score @s ct_joined matches 2 if score #black_ready gm_ctx matches 1 if score #white_ready gm_ctx matches 1 run scoreboard players set #side_ok gm_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready gm_ctx matches 1 run scoreboard players set #side_ok gm_ctx 1
execute if score @s ct_joined matches 1 if score #white_ready gm_ctx matches 1 run scoreboard players set #side_ok gm_ctx 1
''')
    put('game/assign_sides', '''
scoreboard players set @s gm_bot 0
execute if score @s ct_joined matches 1 run return run function gomoku:game/solo_sides
execute if score @s gm_first matches 0 run function gomoku:game/random_first
execute if score @s gm_first matches 1 run function gomoku:game/chosen_first
''')
    put('game/solo_sides', '''
# 单人也保留入座选边／随机黑白的规则，人机是虚拟对手，不创建假玩家。
scoreboard players set #human_side gm_ctx 1
execute if score @s gm_first matches 0 store result score #human_side gm_ctx run random value 0..1
execute if score #human_side gm_ctx matches 0 run scoreboard players set #human_side gm_ctx -1
execute if score @s gm_first matches 1 run scoreboard players operation #human_side gm_ctx = @a[tag=gm.audience,limit=1] gm_weight
scoreboard players operation @a[tag=gm.audience,limit=1] gm_side = #human_side gm_ctx
scoreboard players operation @s gm_bot = #human_side gm_ctx
scoreboard players operation @s gm_bot *= #minus gm_ctx
''')
    put('game/random_first', '''
scoreboard players set @a[tag=gm.audience] gm_side -1
scoreboard players set @a[tag=gm.audience,sort=random,limit=1] gm_side 1
''')
    put('game/chosen_first', '''
scoreboard players set @a[tag=gm.audience] gm_side -1
execute as @a[tag=gm.audience] if score @s gm_weight matches 1 run scoreboard players set @s gm_side 1
''')
    announce_sides = [
        'data modify storage gomoku:runtime sides.black set value {selector:"@a[tag=gm.audience,scores={gm_side=1}]"}',
        'data modify storage gomoku:runtime sides.white set value {selector:"@a[tag=gm.audience,scores={gm_side=-1}]"}',
    ]
    for level, name in [(1, '简单'), (2, '普通'), (3, '困难')]:
        for side, field in [(1, 'black'), (-1, 'white')]:
            announce_sides += [f'execute if score @s gm_bot matches {side} if score @s gm_level matches {level} run data modify storage gomoku:runtime sides.{field} set value {{text:"{name}人机",color:"aqua"}}']
    announce_sides += ['function gomoku:game/announce_sides_text with storage gomoku:runtime sides']
    put('game/announce_sides', announce_sides)
    put('game/announce_sides_text', '$tellraw @a[tag=gm.audience] [{text:"[五子棋] 黑方：",color:"black"},$(black),{text:"　白方：",color:"gray"},$(white)]')
    sides = {(4, 0): ((3, 3), (1, 1)), (4, 1): ((4, 4), (2, 2)),
             (8, 0): ((5, 6), (1, 2)), (8, 1): ((7, 8), (3, 4))}
    side_seats = ['scoreboard players operation #cap gm_ctx = @s ct_capacity',
                  'scoreboard players operation #orient gm_ctx = @s gm_orient']
    seat_side = ['scoreboard players set @s gm_weight 0']
    hints = []
    for (cap, orient), (black, white) in sides.items():
        guard = f'execute if score #cap gm_ctx matches {cap} if score #orient gm_ctx matches {orient}'
        for name, seats, side in [('black', black, 1), ('white', white, -1)]:
            for bound, value in [('seat', seats[0]), ('last', seats[1])]:
                side_seats.append(f'{guard} run scoreboard players set #{name}_{bound} gm_ctx {value}')
            seat_range = str(seats[0]) if seats[0] == seats[1] else f'{seats[0]}..{seats[1]}'
            seat_side.append(f'{guard} if score @s ct_seat matches {seat_range} run scoreboard players set @s gm_weight {side}')
        def seats_text(bounds):
            return str(bounds[0]) if bounds[0] == bounds[1] else f'{bounds[0]}／{bounds[1]}'
        hints.append(guard + ' run ' + say(f'自行选边时，请坐黑方侧 {seats_text(black)} 号位或白方侧 {seats_text(white)} 号位；双人局须两侧各一人，也可改用随机黑白。', '@a[tag=ct.start_actor,limit=1]', 'black'))
    put('system/side_seats', side_seats)
    put('player/seat_side', seat_side)
    put('player/weight', 'function gomoku:player/seat_side')
    put('game/seat_hint', hints)
    put('game/reseat', '''
# 两人先一起下座，再改双方身份并骑乘，互换阵营时不会被旧乘客占住。
# 通用层以玩家 ct_id + ct_seat 判断占用；无需修改其他桌子的座椅。
function gomoku:system/side_seats
execute as @a[tag=gm.audience] run ride @s dismount
execute as @a[tag=gm.audience] run function gomoku:player/place_side
# 虚拟对手同样占用对应边的逻辑座号，供吃子区朝向和阵营显示使用。
scoreboard players operation @s gm_black = #black_seat gm_ctx
scoreboard players operation @s gm_white = #white_seat gm_ctx
execute unless score @s gm_bot matches 1 run scoreboard players operation @s gm_black = @a[tag=gm.audience,scores={gm_side=1},limit=1] gm_seat
execute unless score @s gm_bot matches -1 run scoreboard players operation @s gm_white = @a[tag=gm.audience,scores={gm_side=-1},limit=1] gm_seat
function cardtable:table/ensure_seats
execute as @a[tag=gm.audience] at @s run function cardtable:seat/mount
''')
    put('player/place_side', '''
# 八座桌保留本来就在对应边的具体座位；否则使用该边的第一个座位。
execute if score @s gm_side matches 1 if score @s ct_seat < #black_seat gm_ctx run scoreboard players operation @s ct_seat = #black_seat gm_ctx
execute if score @s gm_side matches 1 if score @s ct_seat > #black_last gm_ctx run scoreboard players operation @s ct_seat = #black_seat gm_ctx
execute if score @s gm_side matches -1 if score @s ct_seat < #white_seat gm_ctx run scoreboard players operation @s ct_seat = #white_seat gm_ctx
execute if score @s gm_side matches -1 if score @s ct_seat > #white_last gm_ctx run scoreboard players operation @s ct_seat = #white_seat gm_ctx
scoreboard players operation @s gm_seat = @s ct_seat
''')
    put('game/actor_guard', '''
# 供控制器回调复用；UI有nonce校验，此处仍复核真人/桌号/身份。
function gomoku:system/context
scoreboard players set #actor_ok gm_ctx 0
execute as @e[tag=gm.actor,tag=gm.audience,limit=1] if score @s gm_table = #table gm_ctx run scoreboard players set #actor_ok gm_ctx 1
''')
    put('game/click', """
function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute unless score @e[tag=gm.actor,limit=1] gm_side = @s gm_turn run return 0
scoreboard players operation #to gm_ctx = #target gm_ctx
function gomoku:engine/check_move
execute unless score #legal gm_ctx matches 1 run return run function gomoku:game/illegal
execute if score @s gm_confirm matches 1 unless score @s gm_sel = #target gm_ctx run return run function gomoku:game/select
function gomoku:game/snapshot
function gomoku:engine/try_move
execute unless score #legal gm_ctx matches 1 run function gomoku:game/illegal
""")
    put('game/select', """
scoreboard players operation @s gm_sel = #target gm_ctx
function gomoku:visual/select
""")
    put('game/illegal', ['scoreboard players set @s gm_sel -1', 'function gomoku:visual/select', 'function gomoku:sound/illegal'])
    put('game/after_move', """
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
scoreboard players set @s gm_animundo 0
data modify entity @s data.gomoku.undo set from entity @s data.gomoku.pending_undo
data remove entity @s data.gomoku.pending_undo
execute store result score #moved_side gm_ctx run data get entity @s data.gomoku.last.side
execute unless score @s gm_bot matches 0 unless score #moved_side gm_ctx = @s gm_bot run data modify entity @s data.gomoku.ai_undo set from entity @s data.gomoku.undo
function gomoku:ai/reset
scoreboard players add @s gm_epoch 1
function gomoku:visual/place
function gomoku:game/announce_move
function gomoku:engine/evaluate
scoreboard players set @s gm_state 2
scoreboard players set @s gm_timer 6
function gomoku:clock/update
function gomoku:ui/refresh
scoreboard players set #legal gm_ctx 1
""")
    announce = ['execute store result score #log_sq gm_ctx run data get entity @s data.gomoku.last.sq',
                'execute store result score #log_side gm_ctx run data get entity @s data.gomoku.last.side',
                'data modify storage gomoku:runtime move.side set value "黑方"',
                'execute if score #log_side gm_ctx matches -1 run data modify storage gomoku:runtime move.side set value "白方"']
    for sq in range(361):
        coord = chr(65 + sq % 19) + str(sq // 19 + 1)
        announce.append(f'execute if score #log_sq gm_ctx matches {sq} run data modify storage gomoku:runtime move.coord set value "{coord}"')
    announce += ['function gomoku:game/announce_text with storage gomoku:runtime move']
    put('game/announce_move', announce)
    put('game/announce_text', '$tellraw @a[tag=gm.audience] [{text:"[五子棋] ",color:"gold"},{text:"$(side) 落子 $(coord)",color:"white"}]')
    put('tick', '''
function gomoku:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14},tag=!gm.controller] at @s run function gomoku:game/init_table
execute as @e[type=minecraft:marker,tag=gm.controller,scores={ct_game=14}] at @s run function gomoku:system/tick
''')
    put('system/tick', '''
scoreboard players add @s gm_pulse 1
execute if score @s gm_state matches 1 run function gomoku:clock/tick
execute if score @s gm_state matches 2 run function gomoku:game/animate_tick
execute if score @s gm_state matches 4 run function gomoku:game/result_tick
execute if score @s gm_state matches 1 run function gomoku:ai/tick
execute if score @s gm_pulse matches 20.. run function gomoku:system/heartbeat
''')
    put('system/heartbeat', '''
scoreboard players set @s gm_pulse 0
function gomoku:system/context
execute if score @s ct_state matches 0 unless entity @e[type=minecraft:interaction,tag=gm.cell,scores={ct_id=0}] run function gomoku:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online gm_ctx 0
execute as @a[tag=gm.audience] run scoreboard players add #online gm_ctx 1
scoreboard players set #expected gm_ctx 2
execute unless score @s gm_bot matches 0 run scoreboard players set #expected gm_ctx 1
execute unless score #online gm_ctx = #expected gm_ctx run return run function gomoku:game/abort
function gomoku:clock/update
'''.replace(' unless entity @e[type=minecraft:interaction,tag=gm.cell,scores={ct_id=0}]',''))
    put('system/check_visual', '''
scoreboard players set #has_visual gm_ctx 0
execute as @e[type=minecraft:interaction,tag=gm.cell] if score @s ct_id = #table gm_ctx run scoreboard players set #has_visual gm_ctx 1
execute if score #has_visual gm_ctx matches 0 run function gomoku:game/preview
''')
    put('game/animate_tick', '''
function gomoku:visual/tick
scoreboard players remove @s gm_timer 1
execute if score @s gm_timer matches ..0 run function gomoku:game/animation_done
''')
    put('game/animation_done', [
        'execute if score @s gm_animundo matches 1 run function gomoku:visual/refresh',
        'execute unless score @s gm_animundo matches 1 run function gomoku:visual/finish_move',
        'execute if score @s gm_result matches 1..3 run return run function gomoku:game/finish',
        'execute unless score @s gm_animundo matches 1 run function gomoku:sound/move',
        'scoreboard players set @s gm_animundo 0',
        'scoreboard players set @s gm_state 1', 'function gomoku:clock/update', 'function gomoku:ui/refresh'])
    put('clock/create', '''
function gomoku:system/context
execute as @e[type=minecraft:text_display,tag=gm.clock] if score @s ct_id = #table gm_ctx run kill @s
execute positioned ~ ~3.00 ~ summon minecraft:text_display run function gomoku:clock/entity
function gomoku:clock/update
''')
    put('clock/entity', '''
tag @s add gm.clock
tag @s add gm.visual
scoreboard players operation @s ct_id = #table gm_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:300,background:0,shadow:1b,see_through:0b,view_range:24f,text:{text:"五子棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
''')
    put('clock/tick', '''
execute if score @s gm_time matches 0 run return 0
execute if score @s gm_turn matches 1 run scoreboard players remove @s gm_btime 1
execute if score @s gm_turn matches -1 run scoreboard players remove @s gm_wtime 1
execute if score @s gm_turn matches 1 if score @s gm_btime matches ..0 run function gomoku:game/timeout
execute if score @s gm_turn matches -1 if score @s gm_wtime matches ..0 run function gomoku:game/timeout
''')
    clock = ['function gomoku:system/context',
        'data modify storage gomoku:runtime clock.poslabel set value "黑"',
        'data modify storage gomoku:runtime clock.neglabel set value "白"',
        'data modify storage gomoku:runtime clock.poscolor set value "white"',
        'data modify storage gomoku:runtime clock.negcolor set value "gray"',
        'execute if score @s gm_turn matches 1 run data modify storage gomoku:runtime clock.poscolor set value "green"',
        'execute if score @s gm_turn matches -1 run data modify storage gomoku:runtime clock.negcolor set value "green"',
        'data modify storage gomoku:runtime clock.status set value "黑方落子"',
        'execute if score @s gm_turn matches -1 run data modify storage gomoku:runtime clock.status set value "白方落子"',
        'execute if score @s gm_state matches 2 run data modify storage gomoku:runtime clock.status set value "落子中"',
        'execute if score @s gm_state matches 4 run data modify storage gomoku:runtime clock.status set from entity @s data.gomoku.result',
    ]
    for level, name in [(1, '简单'), (2, '普通'), (3, '困难')]:
        clock += [f'execute if score @s gm_bot matches 1 if score @s gm_level matches {level} run data modify storage gomoku:runtime clock.poslabel set value "黑·{name}人机"',
                  f'execute if score @s gm_bot matches -1 if score @s gm_level matches {level} run data modify storage gomoku:runtime clock.neglabel set value "白·{name}人机"']
        clock += [f'execute unless score @s gm_bot matches 0 if score @s gm_level matches {level} if score @s gm_state matches 1 if score @s gm_turn = @s gm_bot run data modify storage gomoku:runtime clock.status set value "{name}人机思考中"']
    for side, field in [('r', 'b'), ('b', 'w')]:
        clock += [f'scoreboard players operation #seconds gm_ctx = @s gm_{field}time',
            'scoreboard players add #seconds gm_ctx 19', 'scoreboard players operation #seconds gm_ctx /= #twenty gm_ctx',
            'scoreboard players operation #minutes gm_ctx = #seconds gm_ctx', 'scoreboard players operation #minutes gm_ctx /= #sixty gm_ctx',
            'scoreboard players operation #seconds gm_ctx %= #sixty gm_ctx',
            f'execute store result storage gomoku:runtime clock.{side}m int 1 run scoreboard players get #minutes gm_ctx']
        clock += [f'execute if score #seconds gm_ctx matches {s} run data modify storage gomoku:runtime clock.{side}s set value "{s:02d}"' for s in range(60)]
    clock += ['execute if score @s gm_time matches 0 run return run function gomoku:clock/unlimited with storage gomoku:runtime clock',
              'function gomoku:clock/timed with storage gomoku:runtime clock']
    put('clock/update', clock)
    put('clock/timed', '$execute as @e[type=minecraft:text_display,tag=gm.clock] if score @s ct_id = #table gm_ctx run data modify entity @s text set value [{text:"五子棋 · $(status)\\n",color:"gold"},{text:"$(poslabel) $(rm):$(rs)",color:"$(poscolor)"},{text:"　│　",color:"dark_gray"},{text:"$(neglabel) $(bm):$(bs)",color:"$(negcolor)"}]')
    put('clock/unlimited', '$execute as @e[type=minecraft:text_display,tag=gm.clock] if score @s ct_id = #table gm_ctx run data modify entity @s text set value [{text:"五子棋 · $(status)\\n",color:"gold"},{text:"$(poslabel)　│　$(neglabel) · 不限时",color:"gray"}]')
    put('game/timeout', '''
function gomoku:system/context
scoreboard players operation #side gm_ctx = @s gm_turn
scoreboard players operation #side gm_ctx *= #minus gm_ctx
scoreboard players set @s gm_result 2
execute if score #side gm_ctx matches 1 run scoreboard players set @s gm_result 1
scoreboard players set @s gm_reason 6
function gomoku:game/finish
''')
    put('game/resign', '''
function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1..2 run return 0
scoreboard players operation #side gm_ctx = @e[tag=gm.actor,limit=1] gm_side
scoreboard players operation #side gm_ctx *= #minus gm_ctx
scoreboard players set @s gm_result 2
execute if score #side gm_ctx matches 1 run scoreboard players set @s gm_result 1
scoreboard players set @s gm_reason 7
function gomoku:game/finish
''')
    put('game/offer_draw', [
        'function gomoku:game/actor_guard', 'execute unless score #actor_ok gm_ctx matches 1 run return 0',
        'execute unless score @s gm_state matches 1 run return 0',
        'execute unless score @s gm_bot matches 0 run return run function gomoku:game/bot_draw',
        'scoreboard players operation @s gm_draw = @e[tag=gm.actor,limit=1] gm_side',
        'scoreboard players set @s gm_undo 0',
        'scoreboard players add @s gm_epoch 1', say('一方提出和棋，可按 Q 在对局面板中接受或拒绝。'), 'function gomoku:ui/refresh'])
    put('game/bot_draw', [say('人机同意和棋。'), 'scoreboard players set @s gm_result 3',
        'scoreboard players set @s gm_reason 8', 'function gomoku:game/finish'])
    put('game/accept_draw', '''
function gomoku:game/actor_guard
execute unless score #actor_ok gm_ctx matches 1 run return 0
execute unless score @s gm_state matches 1 run return 0
execute if score @s gm_draw matches 0 run return 0
execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_draw run return 0
scoreboard players set @s gm_result 3
scoreboard players set @s gm_reason 8
function gomoku:game/finish
''')
    put('game/decline_draw', [
        'function gomoku:game/actor_guard', 'execute unless score #actor_ok gm_ctx matches 1 run return 0',
        'execute unless score @s gm_state matches 1 run return 0', 'execute if score @s gm_draw matches 0 run return 0',
        'execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_draw run return 0',
        'scoreboard players set @s gm_draw 0', 'scoreboard players add @s gm_epoch 1', say('和棋提议已被拒绝。'), 'function gomoku:ui/refresh'])

    # 保存最后一着之前的完整局面。非法尝试只写pending，不覆盖已可悔的上一着。
    undo_scores = ['turn','moves','last','btime','wtime']
    snapshot = ['function gomoku:system/context',
        'data modify entity @s data.gomoku.pending_undo set value {board:[]}',
        'data modify entity @s data.gomoku.pending_undo.history set from entity @s data.gomoku.history',
        'data modify entity @s data.gomoku.pending_undo.captublack set from entity @s data.gomoku.captublack']
    snapshot += [f'execute store result entity @s data.gomoku.pending_undo.{field} int 1 run scoreboard players get @s gm_{field}' for field in undo_scores]
    for sq in range(361):
        snapshot += ['data modify entity @s data.gomoku.pending_undo.board append value 0',
            f'execute store result entity @s data.gomoku.pending_undo.board[{sq}] int 1 run scoreboard players get @e[type=minecraft:marker,tag=gm.board,scores={{gm_sq={sq}}},limit=1] gm_piece']
    put('game/snapshot', snapshot)
    put('game/offer_undo', [
        'function gomoku:game/actor_guard', 'execute unless score #actor_ok gm_ctx matches 1 run return 0',
        'execute unless score @s gm_state matches 1 run return 0',
        'execute unless score @s gm_bot matches 0 run return run function gomoku:game/bot_undo',
        'execute unless data entity @s data.gomoku.undo run ' + say('目前没有可撤回的落子。', '@a[tag=gm.actor]', 'black'),
        'execute unless data entity @s data.gomoku.undo run return 0',
        'scoreboard players operation @s gm_undo = @e[tag=gm.actor,limit=1] gm_side',
        'scoreboard players set @s gm_draw 0', 'scoreboard players add @s gm_epoch 1',
        say('对手申请悔棋，手持对局菜单按 Q 回应。'),
        'function gomoku:ui/refresh'])
    put('game/bot_undo', [
        'execute unless data entity @s data.gomoku.ai_undo run ' + say('你还没有可撤回的落子。', '@a[tag=gm.actor]', 'black'),
        'execute unless data entity @s data.gomoku.ai_undo run return 0',
        'data modify entity @s data.gomoku.undo set from entity @s data.gomoku.ai_undo',
        'function gomoku:game/restore_undo'])
    put('game/decline_undo', [
        'function gomoku:game/actor_guard','execute unless score #actor_ok gm_ctx matches 1 run return 0',
        'execute unless score @s gm_state matches 1 run return 0', 'execute if score @s gm_undo matches 0 run return 0',
        'execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_undo run return 0',
        'scoreboard players set @s gm_undo 0', 'scoreboard players add @s gm_epoch 1',
        say('悔棋申请已被拒绝。'), 'function gomoku:ui/refresh'])
    restore_guard = ['function gomoku:game/actor_guard','execute unless score #actor_ok gm_ctx matches 1 run return 0',
        'execute unless score @s gm_state matches 1 run return 0', 'execute if score @s gm_undo matches 0 run return 0',
        'execute if score @e[tag=gm.actor,limit=1] gm_side = @s gm_undo run return 0',
        'execute unless data entity @s data.gomoku.undo run return 0']
    put('game/accept_undo', restore_guard + ['function gomoku:game/restore_undo'])
    restore = ['function gomoku:ai/reset']
    restore += [f'execute store result score @s gm_{field} run data get entity @s data.gomoku.undo.{field}' for field in undo_scores]
    restore += ['data modify entity @s data.gomoku.history set from entity @s data.gomoku.undo.history',
        'data modify entity @s data.gomoku.captublack set from entity @s data.gomoku.undo.captublack',
        'data modify storage gomoku:undo saved set from entity @s data.gomoku.undo']
    for sq in range(361):
        restore += [f'execute store result score #restore gm_ctx run data get storage gomoku:undo saved.board[{sq}]',
                    f'scoreboard players operation @e[type=minecraft:marker,tag=gm.board,scores={{gm_sq={sq}}},limit=1] gm_piece = #restore gm_ctx']
    restore += ['data remove entity @s data.gomoku.undo', 'data remove entity @s data.gomoku.pending_undo',
        'data remove entity @s data.gomoku.ai_undo',
        'data remove storage gomoku:undo saved',
        'scoreboard players set @s gm_undo 0','scoreboard players set @s gm_draw 0',
        'scoreboard players set @s gm_sel -1','scoreboard players set @s gm_result 0','scoreboard players set @s gm_reason 0',
        'scoreboard players add @s gm_epoch 1', 'function gomoku:visual/undo', 'function gomoku:sound/undo', 'scoreboard players set @s gm_animundo 1', 'scoreboard players set @s gm_state 2', 'scoreboard players set @s gm_timer 6', 'function gomoku:clock/update',
        'function gomoku:ui/refresh',
        'execute if score @s gm_bot matches 0 run ' + say('对手同意悔棋，已撤回最后一步，并恢复该步之前的局面与时钟。'),
        'execute unless score @s gm_bot matches 0 run ' + say('人机同意悔棋，已恢复到你上次落子之前的局面与时钟。')]
    put('game/restore_undo', restore)
    reasons = {1:'连成五子',2:'棋盘已满',6:'超时',7:'认输',8:'双方同意和棋',11:'棋盘数据不完整或异常'}
    finish = ['# 先锁定结算，重复调用不能重置倒计时或再次庆祝。',
              'execute unless score @s gm_state matches 1..2 run return 0',
              'execute unless score @s gm_result matches 1..3 run return 0',
              'scoreboard players set @s gm_state 4',
              'function gomoku:system/context',
              'function gomoku:ai/reset',
              'function gomoku:sound/end', 'scoreboard players set @s gm_timer 100',
              'scoreboard players set @s gm_sel -1', 'scoreboard players set @s gm_draw 0', 'scoreboard players set @s gm_undo 0', 'scoreboard players add @s gm_epoch 1',
              'function gomoku:visual/finish_move', 'function gomoku:visual/select',
              'data modify entity @s data.gomoku.result set value "和棋"',
              'execute if score @s gm_result matches 1 run data modify entity @s data.gomoku.result set value "黑方获胜"',
              'execute if score @s gm_result matches 2 run data modify entity @s data.gomoku.result set value "白方获胜"',
              'data modify storage gomoku:runtime result.title set from entity @s data.gomoku.result',
              'data modify storage gomoku:runtime result.reason set value "对局结束"']
    finish += [f'execute if score @s gm_reason matches {n} run data modify storage gomoku:runtime result.reason set value "{reason}"' for n,reason in reasons.items()]
    finish += ['execute if score @s gm_result matches 1..2 run function gomoku:game/firework',
               'function gomoku:game/result_text with storage gomoku:runtime result', 'function gomoku:clock/update', 'function gomoku:ui/refresh', 'function gomoku:log {text:"对局结束，五秒后返回大厅"}']
    put('game/finish', finish)
    put('game/firework', '''
# 优先在获胜真人处庆祝；虚拟对手使用本桌对应阵营的座椅。
scoreboard players set #winner gm_ctx 1
execute if score @s gm_result matches 2 run scoreboard players set #winner gm_ctx -1
scoreboard players set #celebrate gm_ctx 0
execute as @a[tag=gm.audience] if score @s gm_side = #winner gm_ctx if score #celebrate gm_ctx matches 0 at @s run function gomoku:game/firework_player
execute if score #celebrate gm_ctx matches 1 run return 1
function gomoku:system/side_seats
scoreboard players operation #victory_seat gm_ctx = #black_seat gm_ctx
execute if score #winner gm_ctx matches -1 run scoreboard players operation #victory_seat gm_ctx = #white_seat gm_ctx
execute if score #winner gm_ctx matches 1 if score @s ct_capacity matches 4 if score @s gm_black matches 1..4 run scoreboard players operation #victory_seat gm_ctx = @s gm_black
execute if score #winner gm_ctx matches 1 if score @s ct_capacity matches 8 if score @s gm_black matches 1..8 run scoreboard players operation #victory_seat gm_ctx = @s gm_black
execute if score #winner gm_ctx matches -1 if score @s ct_capacity matches 4 if score @s gm_white matches 1..4 run scoreboard players operation #victory_seat gm_ctx = @s gm_white
execute if score #winner gm_ctx matches -1 if score @s ct_capacity matches 8 if score @s gm_white matches 1..8 run scoreboard players operation #victory_seat gm_ctx = @s gm_white
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table gm_ctx if score @s ct_seat = #victory_seat gm_ctx if score #celebrate gm_ctx matches 0 at @s run function gomoku:game/firework_player
execute if score #celebrate gm_ctx matches 0 run function gomoku:game/firework_fallback
''')
    fallback=[]
    for cap,positions in [(4,[(0,-2),(2,0),(0,2),(-2,0)]),
                          (8,[(-1,-2.5),(1,-2.5),(2.5,-1),(2.5,1),(1,2.5),(-1,2.5),(-2.5,1),(-2.5,-1)])]:
        for seat,(x,z) in enumerate(positions,1):
            fallback.append(f'execute if score @s ct_capacity matches {cap} if score #victory_seat gm_ctx matches {seat} positioned ~{x} ~0.32 ~{z} run function gomoku:game/firework_player')
    put('game/firework_fallback',fallback)
    put('game/firework_player','''
scoreboard players set #celebrate gm_ctx 1
tag @e[type=minecraft:firework_rocket,tag=gm.firework.new] remove gm.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["gm.firework","gm.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=gm.firework.new] ct_id = #table gm_ctx
tag @e[type=minecraft:firework_rocket,tag=gm.firework.new] remove gm.firework.new
''')
    put('game/result_text', '$tellraw @a[tag=gm.audience] [{text:"[五子棋] $(title)",color:"gold",bold:true},{text:"：$(reason)。五秒后返回大厅。",color:"yellow"}]')
    put('game/result_tick', '''
scoreboard players remove @s gm_timer 1
execute if score @s gm_timer matches ..0 run function gomoku:game/cleanup
''')
    put('player/clear_state', '''
function gomoku:input/clear
scoreboard players reset @s gm_table
scoreboard players reset @s gm_side
scoreboard players reset @s gm_seat
scoreboard players reset @s gm_weight
tag @s remove gm.player
tag @s remove gm.audience
''')
    put('game/cleanup', '''
# 返回大厅并保留终局棋面，清除计时和输入；再次开局或切换游戏才重摆。
scoreboard players set @s gm_state 0
scoreboard players set @s gm_sel -1
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
data modify entity @s data.gomoku.review set value 1b
function gomoku:ai/reset
function gomoku:system/context
function gomoku:visual/finish_move
function gomoku:visual/select
execute as @e[type=minecraft:firework_rocket,tag=gm.firework] if score @s ct_id = #table gm_ctx run kill @s
execute as @e[type=minecraft:text_display,tag=gm.clock] if score @s ct_id = #table gm_ctx run kill @s
execute as @a[tag=gm.player] if score @s gm_table = #table gm_ctx run function gomoku:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}] run function gomoku:player/kill_drop
function cardtable:game/return_lobby
''')
    put('player/kill_drop', '''
execute store result score #drop_table gm_ctx run data get entity @s Item.components."minecraft:custom_data".gomoku.table
execute if score #drop_table gm_ctx = #table gm_ctx run kill @s
''')
    put('game/remove', '''
# 切换游戏/删除牌桌专用：不重新生成预览，不更改即将选中的游戏。
function gomoku:settings/invalidate_table
function gomoku:ai/reset
data remove entity @s data.gomoku.review
function gomoku:system/context
execute as @a[tag=gm.player] if score @s gm_table = #table gm_ctx run function gomoku:player/clear_state
function gomoku:visual/clear
execute as @e[type=minecraft:firework_rocket,tag=gm.firework] if score @s ct_id = #table gm_ctx run kill @s
kill @e[type=minecraft:marker,tag=gm.board]
tag @s remove gm.controller
tag @s remove gm.current
scoreboard players set @s gm_state 0
''')
    put('game/abort', ['execute unless entity @s[tag=gm.controller] run return fail', 'function gomoku:system/context', say('本场已中止，牌桌返回大厅。'), 'function gomoku:game/cleanup'])
    put('game/end_vote', ['execute unless entity @s[tag=gm.controller] run return fail', 'function gomoku:system/context', say('结束投票通过，本场提前结束。'), 'function gomoku:game/cleanup'])
    put('admin/abort', '''
# 可直接 /function 调用；只处理同维度八格内最近的一场五子棋。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[五子棋] 同维度 8 格内没有正在运行的五子棋牌桌。',color:'black'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function gomoku:game/abort
''')
    put('log', '$tellraw @a[tag=ct.debug] [{text:"[五子棋 Debug] $(text)",color:"gray"}]')
    print('Generated gomoku lifecycle / clock / admin functions.')


if __name__ == '__main__':
    main()
