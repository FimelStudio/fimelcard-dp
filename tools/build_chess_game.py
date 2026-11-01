"""生成国际象棋生命周期、计时及通用牌桌接入外的游戏函数。

规则/UI/模型分别由 build_chess_engine/ui/visual.py 维护。运行本脚本只更新
chess 的 load/tick/system/game/player/admin/clock/log，不重写其他模块。
"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / 'data/chess/function'


def put(name, lines):
    target = ROOT / (name + '.mcfunction')
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')


def say(text, target='@a[tag=ch.audience]', color='yellow'):
    return 'tellraw ' + target + ' ' + json.dumps({'text': '[国际象棋] ' + text, 'color': color}, ensure_ascii=False)


def main():
    from build_chess_sound import build as build_sound
    build_sound(ROOT)
    from build_chess_ai import build as build_ai
    build_ai(ROOT)
    dummy = '''ch_ctx ch_state ch_sq ch_piece ch_turn ch_castle ch_ep ch_half ch_full
ch_epoch ch_result ch_reason ch_check ch_repetition ch_sel ch_pfrom ch_pto ch_timer
ch_white ch_black ch_table ch_side ch_seat ch_weight ch_wtime ch_btime ch_board ch_palette
ch_orient ch_time ch_draw ch_pulse ch_owner ch_slot ch_wcapt ch_bcapt
ch_seen ch_ui_load ch_ui_tmp ch_set_table ch_setnonce ch_setepoch ch_nonce ch_first ch_undo
ch_bot ch_level ch_hints ch_aistate ch_aiwait ch_aiepoch'''.split()
    put('system/install', [f'scoreboard objectives add {o} dummy' for o in dummy if o != 'ch_ctx'] + [
        'scoreboard objectives add ch_action trigger', 'scoreboard objectives add ch_settings trigger',
        'scoreboard objectives add ch_drop minecraft.dropped:minecraft.paper',
        'scoreboard players set #version ch_ctx 3'])
    put('system/upgrade_v2', '''
# 兼容制作过程中已加载的早期国际象棋：补新目标，不清空现有棋局。
scoreboard objectives add ch_first dummy
scoreboard objectives add ch_undo dummy
execute as @e[tag=ch.controller] unless score @s ch_first matches 0..1 run scoreboard players set @s ch_first 1
execute as @e[tag=ch.controller] unless score @s ch_undo matches -1..1 run scoreboard players set @s ch_undo 0
scoreboard players set #version ch_ctx 2
''')
    put('system/upgrade_v3', '''
# 新增人机与走格提示，保留现有双人局面和设置。
scoreboard objectives add ch_bot dummy
scoreboard objectives add ch_level dummy
scoreboard objectives add ch_hints dummy
scoreboard objectives add ch_aistate dummy
scoreboard objectives add ch_aiwait dummy
scoreboard objectives add ch_aiepoch dummy
execute as @e[tag=ch.controller] run scoreboard players set @s ch_bot 0
execute as @e[tag=ch.controller] run scoreboard players set @s ch_level 2
execute as @e[tag=ch.controller] run scoreboard players set @s ch_hints 1
scoreboard players set #version ch_ctx 3
''')
    put('load', '''
scoreboard objectives add ch_ctx dummy
execute unless score #version ch_ctx matches 1.. run function chess:system/install
execute if score #version ch_ctx matches 1 run function chess:system/upgrade_v2
execute if score #version ch_ctx matches 2 run function chess:system/upgrade_v3
# 分边默认按座位（1）；合法的显式随机（0）保留，旧指定座位值迁为默认。
execute as @e[tag=ch.controller] unless score @s ch_first matches 0..1 run scoreboard players set @s ch_first 1
scoreboard players set #minus ch_ctx -1
scoreboard players set #two ch_ctx 2
scoreboard players set #four ch_ctx 4
scoreboard players set #eight ch_ctx 8
scoreboard players set #twenty ch_ctx 20
scoreboard players set #sixty ch_ctx 60
scoreboard players set #thousand ch_ctx 1000
execute unless score #setting_serial ch_ctx matches 100000..999999 run scoreboard players set #setting_serial ch_ctx 99999
scoreboard players add #ui_load ch_ctx 1
scoreboard players reset * ch_action
scoreboard players reset * ch_settings
scoreboard players reset * ch_setnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12}] at @s run function chess:system/reload
''')
    put('system/context', '''
# 每个入口重新绑定桌号；规则/交互均不依赖“最近实体”。
scoreboard players operation #table ch_ctx = @s ct_id
tag @e[tag=ch.current] remove ch.current
tag @e[tag=ch.board] remove ch.board
tag @a[tag=ch.audience] remove ch.audience
tag @e[tag=ch.audience] remove ch.audience
tag @s add ch.current
execute as @e[type=minecraft:marker,tag=ch.square] if score @s ct_id = #table ch_ctx run tag @s add ch.board
execute as @e[tag=ch.player,tag=ct.player] if score @s ch_table = #table ch_ctx if score @s ct_id = #table ch_ctx run tag @s add ch.audience
''')
    put('game/init_table', '''
tag @s add ch.controller
execute unless score @s ch_board matches 0..4 run scoreboard players set @s ch_board 0
execute unless score @s ch_palette matches 0..3 run scoreboard players set @s ch_palette 0
execute unless score @s ch_orient matches 0..1 run scoreboard players set @s ch_orient 0
execute unless score @s ch_time matches 0..30 run scoreboard players set @s ch_time 10
execute unless score @s ch_first matches 0..1 run scoreboard players set @s ch_first 1
execute unless score @s ch_level matches 1..3 run scoreboard players set @s ch_level 2
execute unless score @s ch_hints matches 0..1 run scoreboard players set @s ch_hints 1
execute unless score @s ch_bot matches -1..1 run scoreboard players set @s ch_bot 0
execute unless score @s ch_epoch matches 1.. run scoreboard players set @s ch_epoch 1
execute if score @s ct_state matches 0 run function chess:game/preview
''')
    put('system/create_board', [
        'function chess:system/context', 'kill @e[type=minecraft:marker,tag=ch.board]',
    ] + [f'execute summon minecraft:marker run function chess:system/square {{sq:{sq}}}' for sq in range(64)] + ['function chess:system/context'])
    put('system/square', '''
tag @s add ch.square
scoreboard players operation @s ct_id = #table ch_ctx
$scoreboard players set @s ch_sq $(sq)
scoreboard players set @s ch_piece 0
''')
    put('game/preview', '''
# 选择游戏或改变外观后立即显示；绝不重置进行中的对局。
execute unless score @s ct_game matches 12 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.chess{review:1b} run return run function chess:game/review
tag @s add ch.controller
scoreboard players set @s ch_state 0
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_timer 0
scoreboard players set @s ch_pulse 0
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
scoreboard players set @s ch_bot 0
function chess:ai/reset
data remove entity @s data.chess.ai_undo
data remove entity @s data.chess.undo
data remove entity @s data.chess.pending_undo
scoreboard players add @s ch_epoch 1
function chess:visual/clear
function chess:system/create_board
function chess:engine/init_board
function chess:visual/setup
''')
    put('game/review', '''
# 大厅保留终局棋面；重载或修改配色只重建展示，不初始化规则局面。
execute unless score @s ct_game matches 12 run return 0
execute unless score @s ct_state matches 0 run return 0
function chess:system/context
scoreboard players set @s ch_state 0
scoreboard players set @s ch_sel -1
scoreboard players add @s ch_epoch 1
function chess:ai/reset
function chess:visual/refresh
''')
    put('system/reload', '''
tag @s add ch.controller
execute if score @s ct_state matches 0 run return run function chess:game/init_table
function chess:system/context
scoreboard players add @s ch_epoch 1
function chess:ai/reset
# 保留阵营，恢复对应桌边与通用座位身份；不重新随机或重置棋局。
function chess:game/reseat
# 规则局面、王车权、过路兵、历史和时钟均保留；重建的只是展示实体。
function chess:visual/refresh
function chess:clock/create
execute as @a[tag=ch.audience] run function chess:input/give
function chess:ui/refresh
execute if score @s ch_state matches 3 as @a[tag=ch.audience] if score @s ch_side = @e[tag=ch.current,limit=1] ch_turn run function chess:ui/promotion
''')
    put('game/start', [
        'function chess:game/init_table',
        'execute unless score @s ct_joined matches 1..2 run ' + say('国际象棋支持一至两名玩家，单人自动匹配人机。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute unless score @s ct_joined matches 1..2 run return fail',
        'function chess:system/context', 'scoreboard players set #online ch_ctx 0', 'scoreboard players set #blocked ch_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx run scoreboard players add #online ch_ctx 1',
        *[f'execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx if items entity @s hotbar.{slot} * unless items entity @s hotbar.{slot} minecraft:paper[minecraft:custom_data~{{chess:{{tool:1b}}}}] run scoreboard players set #blocked ch_ctx 1' for slot in (8,)],
        'execute unless score #online ch_ctx = @s ct_joined run ' + say('入座的玩家都需要在线。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute unless score #online ch_ctx = @s ct_joined run return fail',
        'execute if score #blocked ch_ctx matches 1 run ' + say('请先清空快捷栏最后一格（第9格）。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute if score #blocked ch_ctx matches 1 run return fail',
        'function chess:system/side_seats',
        'scoreboard players set #white_ready ch_ctx 0',
        'scoreboard players set #black_ready ch_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx run function chess:player/seat_side',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx if score @s ch_weight matches 1 run scoreboard players add #white_ready ch_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx if score @s ch_weight matches -1 run scoreboard players add #black_ready ch_ctx 1',
        'execute if score @s ch_first matches 1 run function chess:game/check_sides',
        'execute if score @s ch_first matches 1 if score #side_ok ch_ctx matches 0 run function chess:game/seat_hint',
        'execute if score @s ch_first matches 1 if score #side_ok ch_ctx matches 0 run return fail',
        'execute as @a[tag=ct.player] if score @s ct_id = #table ch_ctx run function chess:player/init',
        'function chess:system/context', 'function chess:game/assign_sides',
        'execute store result score #seats_ok ch_ctx run function chess:game/reseat',
        'execute unless score #seats_ok ch_ctx matches 1 run return run function chess:game/abort',
        'function chess:ai/reset', 'data remove entity @s data.chess.ai_undo',
        'function chess:settings/invalidate_table',
        'data remove entity @s data.chess.review',
        'scoreboard players set @s ch_state 1', 'scoreboard players set @s ch_sel -1',
        'scoreboard players set @s ch_timer 0', 'scoreboard players set @s ch_pulse 0', 'scoreboard players set @s ch_draw 0',
        'scoreboard players add @s ch_epoch 1', 'function chess:engine/init_board', 'function chess:visual/setup',
        'scoreboard players operation @s ch_wtime = @s ch_time',
        'scoreboard players set #minute ch_ctx 1200', 'scoreboard players operation @s ch_wtime *= #minute ch_ctx',
        'scoreboard players operation @s ch_btime = @s ch_wtime',
        'execute as @a[tag=ch.audience] run function chess:input/give',
        'scoreboard players set @s ct_start 1', 'function chess:clock/create', 'function chess:ui/refresh',
        'function chess:sound/start',
        say('白方先行。右键选子、落子；手持最后一格的对局菜单按 Q。'),
        'function chess:game/announce_sides',
        'function chess:log {text:"对局开始"}',
    ])
    put('player/init', '''
tag @s add ch.player
scoreboard players operation @s ch_table = @s ct_id
scoreboard players operation @s ch_seat = @s ct_seat
scoreboard players set @s ch_side -1
scoreboard players set @s ch_seen -1
''')
    # 白方始终先行；这里只决定谁执白，阵营再决定实际座位。
    put('game/check_sides', '''
scoreboard players set #side_ok ch_ctx 0
execute if score @s ct_joined matches 2 if score #white_ready ch_ctx matches 1 if score #black_ready ch_ctx matches 1 run scoreboard players set #side_ok ch_ctx 1
execute if score @s ct_joined matches 1 if score #white_ready ch_ctx matches 1 run scoreboard players set #side_ok ch_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready ch_ctx matches 1 run scoreboard players set #side_ok ch_ctx 1
''')
    put('game/assign_sides', '''
scoreboard players set @s ch_bot 0
execute if score @s ct_joined matches 1 run return run function chess:game/solo_sides
execute if score @s ch_first matches 0 run function chess:game/random_first
execute if score @s ch_first matches 1 run function chess:game/chosen_first
''')
    put('game/solo_sides', '''
# 单人也保留入座选边／随机黑白的规则，人机是虚拟对手，不创建假玩家。
scoreboard players set #human_side ch_ctx 1
execute if score @s ch_first matches 0 store result score #human_side ch_ctx run random value 0..1
execute if score #human_side ch_ctx matches 0 run scoreboard players set #human_side ch_ctx -1
execute if score @s ch_first matches 1 run scoreboard players operation #human_side ch_ctx = @a[tag=ch.audience,limit=1] ch_weight
scoreboard players operation @a[tag=ch.audience,limit=1] ch_side = #human_side ch_ctx
scoreboard players operation @s ch_bot = #human_side ch_ctx
scoreboard players operation @s ch_bot *= #minus ch_ctx
''')
    put('game/random_first', '''
scoreboard players set @a[tag=ch.audience] ch_side -1
scoreboard players set @a[tag=ch.audience,sort=random,limit=1] ch_side 1
''')
    put('game/chosen_first', '''
scoreboard players set @a[tag=ch.audience] ch_side -1
execute as @a[tag=ch.audience] if score @s ch_weight matches 1 run scoreboard players set @s ch_side 1
''')
    announce_sides = [
        'data modify storage chess:runtime sides.white set value {selector:"@a[tag=ch.audience,scores={ch_side=1}]"}',
        'data modify storage chess:runtime sides.black set value {selector:"@a[tag=ch.audience,scores={ch_side=-1}]"}',
    ]
    for level, name in [(1, '简单'), (2, '普通'), (3, '困难')]:
        for side, field in [(1, 'white'), (-1, 'black')]:
            announce_sides += [f'execute if score @s ch_bot matches {side} if score @s ch_level matches {level} run data modify storage chess:runtime sides.{field} set value {{text:"{name}人机",color:"aqua"}}']
    announce_sides += ['function chess:game/announce_sides_text with storage chess:runtime sides']
    put('game/announce_sides', announce_sides)
    put('game/announce_sides_text', '$tellraw @a[tag=ch.audience] [{text:"[国际象棋] 白方：",color:"white"},$(white),{text:"　黑方：",color:"gray"},$(black)]')
    sides = {(4, 0): ((3, 3), (1, 1)), (4, 1): ((4, 4), (2, 2)),
             (8, 0): ((5, 6), (1, 2)), (8, 1): ((7, 8), (3, 4))}
    side_seats = ['scoreboard players operation #cap ch_ctx = @s ct_capacity',
                  'scoreboard players operation #orient ch_ctx = @s ch_orient']
    seat_side = ['scoreboard players set @s ch_weight 0']
    hints = []
    for (cap, orient), (white, black) in sides.items():
        guard = f'execute if score #cap ch_ctx matches {cap} if score #orient ch_ctx matches {orient}'
        for name, seats, side in [('white', white, 1), ('black', black, -1)]:
            for bound, value in [('seat', seats[0]), ('last', seats[1])]:
                side_seats.append(f'{guard} run scoreboard players set #{name}_{bound} ch_ctx {value}')
            seat_range = str(seats[0]) if seats[0] == seats[1] else f'{seats[0]}..{seats[1]}'
            seat_side.append(f'{guard} if score @s ct_seat matches {seat_range} run scoreboard players set @s ch_weight {side}')
        def seats_text(bounds):
            return str(bounds[0]) if bounds[0] == bounds[1] else f'{bounds[0]}／{bounds[1]}'
        hints.append(guard + ' run ' + say(f'自行选边时，请坐白方侧 {seats_text(white)} 号位或黑方侧 {seats_text(black)} 号位；双人局须两侧各一人，也可改用随机黑白。', '@a[tag=ct.start_actor,limit=1]', 'red'))
    put('system/side_seats', side_seats)
    put('player/seat_side', seat_side)
    put('player/weight', 'function chess:player/seat_side')
    put('game/seat_hint', hints)
    put('game/reseat', '''
# 先冻结双方目标座位，再全部下座、统一更新身份，最后按阵营分别骑乘。
# 不让尚未执行的玩家继续占用另一方目标，也不让临时选择器跨玩家串位。
function chess:system/context
function chess:system/side_seats
scoreboard players set #white_ready ch_ctx 0
scoreboard players set #black_ready ch_ctx 0
execute as @a[tag=ch.audience,scores={ch_side=1}] run scoreboard players add #white_ready ch_ctx 1
execute as @a[tag=ch.audience,scores={ch_side=-1}] run scoreboard players add #black_ready ch_ctx 1
execute if score @s ch_bot matches 1 run scoreboard players add #white_ready ch_ctx 1
execute if score @s ch_bot matches -1 run scoreboard players add #black_ready ch_ctx 1
execute unless score #white_ready ch_ctx matches 1 run return 0
execute unless score #black_ready ch_ctx matches 1 run return 0
execute as @a[tag=ch.audience] run function chess:player/place_side
execute as @a[tag=ch.audience] run ride @s dismount
execute as @a[tag=ch.audience] run scoreboard players operation @s ct_seat = @s ch_seat
# 虚拟对手同样占用对应边的逻辑座号，供吃子区朝向和阵营显示使用。
scoreboard players operation @s ch_white = #white_seat ch_ctx
scoreboard players operation @s ch_black = #black_seat ch_ctx
execute unless score @s ch_bot matches 1 run scoreboard players operation @s ch_white = @a[tag=ch.audience,scores={ch_side=1},limit=1] ch_seat
execute unless score @s ch_bot matches -1 run scoreboard players operation @s ch_black = @a[tag=ch.audience,scores={ch_side=-1},limit=1] ch_seat
function cardtable:table/ensure_seats
scoreboard players set #seats_ok ch_ctx 1
execute as @a[tag=ch.audience,scores={ch_side=1},limit=1] at @s run function chess:player/mount_side
execute as @a[tag=ch.audience,scores={ch_side=-1},limit=1] at @s run function chess:player/mount_side
return run scoreboard players get #seats_ok ch_ctx
''')
    put('player/place_side', '''
# 只计算目标，暂不修改通用座位，避免双方互换时出现中间的同座身份。
scoreboard players operation @s ch_seat = @s ct_seat
execute if score @s ch_side matches 1 if score @s ch_seat < #white_seat ch_ctx run scoreboard players operation @s ch_seat = #white_seat ch_ctx
execute if score @s ch_side matches 1 if score @s ch_seat > #white_last ch_ctx run scoreboard players operation @s ch_seat = #white_seat ch_ctx
execute if score @s ch_side matches -1 if score @s ch_seat < #black_seat ch_ctx run scoreboard players operation @s ch_seat = #black_seat ch_ctx
execute if score @s ch_side matches -1 if score @s ch_seat > #black_last ch_ctx run scoreboard players operation @s ch_seat = #black_seat ch_ctx
''')
    put('player/mount_side', '''
# 每一方单独完成通用骑乘及核验，再处理下一方；不共享待骑乘目标。
function cardtable:seat/mount
scoreboard players operation #mount_seat ch_ctx = @s ch_seat
scoreboard players set #mounted ch_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table ch_ctx if score @s ct_seat = #mount_seat ch_ctx run scoreboard players set #mounted ch_ctx 1
execute unless score #mounted ch_ctx matches 1 run scoreboard players set #seats_ok ch_ctx 0
''')
    put('game/actor_guard', '''
# 供控制器回调复用；UI有nonce校验，此处仍复核真人/桌号/身份。
function chess:system/context
scoreboard players set #actor_ok ch_ctx 0
execute as @e[tag=ch.actor,tag=ch.audience,limit=1] if score @s ch_table = #table ch_ctx run scoreboard players set #actor_ok ch_ctx 1
''')
    put('game/click', [
        'function chess:game/actor_guard', 'execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0',
        'execute unless score @e[tag=ch.actor,limit=1] ch_side = @s ch_turn run return 0',
        'execute unless score #target ch_ctx matches 0..63 run return 0',
        'scoreboard players set #chosen ch_ctx 0',
        'execute as @e[type=minecraft:marker,tag=ch.board] if score @s ch_sq = #target ch_ctx run scoreboard players operation #chosen ch_ctx = @s ch_piece',
        'scoreboard players operation #chosen ch_ctx *= @s ch_turn',
        'execute if score #chosen ch_ctx matches 1..6 run return run function chess:game/select',
        'execute if score @s ch_sel matches -1 run return 0',
        'scoreboard players operation #from ch_ctx = @s ch_sel', 'scoreboard players operation #to ch_ctx = #target ch_ctx',
        'scoreboard players set #promo ch_ctx 0', 'function chess:game/snapshot', 'function chess:engine/try_move',
        'execute if score #legal ch_ctx matches 0 run function chess:game/illegal',
        'execute if score #legal ch_ctx matches 2 run function chess:game/promotion_pending',
    ])
    put('game/select', [
        'scoreboard players set #chosen ch_ctx 0',
        'execute as @e[type=minecraft:marker,tag=ch.board] if score @s ch_sq = #target ch_ctx run scoreboard players operation #chosen ch_ctx = @s ch_piece',
        'scoreboard players operation #chosen ch_ctx *= @s ch_turn',
        'execute unless score #chosen ch_ctx matches 1..6 run return 0',
        'scoreboard players operation @s ch_sel = #target ch_ctx', 'function chess:visual/select',
        *[f'execute if score #chosen ch_ctx matches {kind} run title @a[tag=ch.actor] actionbar {{text:"已选择：{name}",color:"gold"}}' for kind,name in enumerate(['','兵','马','象','车','后','王']) if kind],
    ])
    put('game/illegal', ['scoreboard players set @s ch_sel -1', 'function chess:visual/select', 'function chess:sound/illegal', say('这一步不合法，请重新选择棋子。', '@a[tag=ch.actor]', 'red')])
    put('game/promotion_pending', '''
scoreboard players operation @s ch_pfrom = #from ch_ctx
scoreboard players operation @s ch_pto = #to ch_ctx
scoreboard players set @s ch_state 3
function chess:hints/clear
scoreboard players add @s ch_epoch 1
execute as @a[tag=ch.actor] run function chess:ui/promotion
''')
    put('game/promote', '''
function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 3 run return 0
execute unless score @e[tag=ch.actor,limit=1] ch_side = @s ch_turn run return 0
execute unless score #promo ch_ctx matches 2..5 run return 0
scoreboard players operation #from ch_ctx = @s ch_pfrom
scoreboard players operation #to ch_ctx = @s ch_pto
function chess:game/snapshot
function chess:engine/try_move
execute if score #legal ch_ctx matches 0 run scoreboard players set @s ch_state 1
execute if score #legal ch_ctx matches 0 run function chess:game/illegal
''')
    put('game/after_move', '''
# engine已原子提交棋面和轮次，此处只读last，随后锁输入到插值结束。
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
data modify entity @s data.chess.undo set from entity @s data.chess.pending_undo
data remove entity @s data.chess.pending_undo
# 单人悔棋保留真人提交前的快照，可连同人机应手撤回到真人回合。
execute store result score #moved_piece ch_ctx run data get entity @s data.chess.last.piece
execute if score @s ch_bot matches 1 if score #moved_piece ch_ctx matches ..-1 run data modify entity @s data.chess.ai_undo set from entity @s data.chess.undo
execute if score @s ch_bot matches -1 if score #moved_piece ch_ctx matches 1.. run data modify entity @s data.chess.ai_undo set from entity @s data.chess.undo
function chess:ai/reset
scoreboard players add @s ch_epoch 1
function chess:visual/move
function chess:game/announce_move
function chess:engine/evaluate
scoreboard players set @s ch_state 2
scoreboard players set @s ch_timer 8
function chess:clock/update
function chess:ui/refresh
function chess:log {text:"合法走子已提交，开始走子/吃子动画"}
scoreboard players set #legal ch_ctx 1
''')
    announce = ['execute store result score #log_from ch_ctx run data get entity @s data.chess.last.from',
                'execute store result score #log_to ch_ctx run data get entity @s data.chess.last.to',
                'execute store result score #log_piece ch_ctx run data get entity @s data.chess.last.piece',
                'execute store result score #log_cap ch_ctx run data get entity @s data.chess.last.captured',
                'execute store result score #log_promo ch_ctx run data get entity @s data.chess.last.promotion',
                'data modify storage chess:runtime move.side set value "白方"',
                'execute if score #log_piece ch_ctx matches ..-1 run data modify storage chess:runtime move.side set value "黑方"',
                'execute if score #log_piece ch_ctx matches ..-1 run scoreboard players operation #log_piece ch_ctx *= #minus ch_ctx',
                'data modify storage chess:runtime move.extra set value ""',
                'execute unless score #log_cap ch_ctx matches 0 run data modify storage chess:runtime move.extra set value "（吃子）"']
    for v, name in enumerate(['', '兵', '马', '象', '车', '后', '王']):
        if v:
            announce += [f'execute if score #log_piece ch_ctx matches {v} run data modify storage chess:runtime move.piece set value "{name}"']
            if v in (2,3,4,5):
                announce += [f'execute if score #log_promo ch_ctx matches {v} run data modify storage chess:runtime move.extra set value "（升变为{name}）"']
    for sq in range(64):
        coord = chr(97 + sq % 8) + str(sq // 8 + 1)
        for field in ['from', 'to']:
            announce.append(f'execute if score #log_{field} ch_ctx matches {sq} run data modify storage chess:runtime move.{field} set value "{coord}"')
    announce += ['function chess:game/announce_text with storage chess:runtime move']
    put('game/announce_move', announce)
    put('game/announce_text', '$tellraw @a[tag=ch.audience] [{text:"[国际象棋] ",color:"gold"},{text:"$(side) $(piece) $(from) → $(to)$(extra)",color:"white"}]')
    put('tick', '''
function chess:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12},tag=!ch.controller] at @s run function chess:game/init_table
execute as @e[type=minecraft:marker,tag=ch.controller,scores={ct_game=12}] at @s run function chess:system/tick
''')
    put('system/tick', '''
scoreboard players add @s ch_pulse 1
execute if score @s ch_state matches 1 run function chess:clock/tick
execute if score @s ch_state matches 3 run function chess:clock/tick
execute if score @s ch_state matches 2 run function chess:game/animate_tick
execute if score @s ch_state matches 4 run function chess:game/result_tick
execute if score @s ch_state matches 1 run function chess:ai/tick
execute if score @s ch_pulse matches 20.. run function chess:system/heartbeat
''')
    put('system/heartbeat', '''
scoreboard players set @s ch_pulse 0
function chess:system/context
execute if score @s ct_state matches 0 unless entity @e[type=minecraft:interaction,tag=ch.cell,scores={ct_id=0}] run function chess:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online ch_ctx 0
execute as @a[tag=ch.audience] run scoreboard players add #online ch_ctx 1
scoreboard players set #expected ch_ctx 2
execute unless score @s ch_bot matches 0 run scoreboard players set #expected ch_ctx 1
execute unless score #online ch_ctx = #expected ch_ctx run return run function chess:game/abort
function chess:clock/update
'''.replace(' unless entity @e[type=minecraft:interaction,tag=ch.cell,scores={ct_id=0}]',''))
    put('system/check_visual', '''
scoreboard players set #has_visual ch_ctx 0
execute as @e[type=minecraft:interaction,tag=ch.cell] if score @s ct_id = #table ch_ctx run scoreboard players set #has_visual ch_ctx 1
execute if score #has_visual ch_ctx matches 0 run function chess:game/preview
''')
    put('game/animate_tick', '''
scoreboard players remove @s ch_timer 1
execute if score @s ch_timer matches ..0 run function chess:game/animation_done
''')
    put('game/animation_done', [
        'function chess:visual/finish_move',
        'execute if score @s ch_result matches 1..3 run return run function chess:game/finish',
        'function chess:sound/landing',
        'scoreboard players set @s ch_state 1', 'function chess:clock/update', 'function chess:ui/refresh',
        'execute if score @s ch_check matches 1 run ' + say('将军！轮到的一方必须解除将军。', color='red')])
    put('clock/create', '''
function chess:system/context
execute as @e[type=minecraft:text_display,tag=ch.clock] if score @s ct_id = #table ch_ctx run kill @s
execute positioned ~ ~3.00 ~ summon minecraft:text_display run function chess:clock/entity
function chess:clock/update
''')
    put('clock/entity', '''
tag @s add ch.clock
tag @s add ch.visual
scoreboard players operation @s ct_id = #table ch_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:300,background:0,shadow:1b,see_through:0b,view_range:24f,text:{text:"国际象棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
''')
    put('clock/tick', '''
execute if score @s ch_time matches 0 run return 0
execute if score @s ch_turn matches 1 run scoreboard players remove @s ch_wtime 1
execute if score @s ch_turn matches -1 run scoreboard players remove @s ch_btime 1
execute if score @s ch_turn matches 1 if score @s ch_wtime matches ..0 run function chess:game/timeout
execute if score @s ch_turn matches -1 if score @s ch_btime matches ..0 run function chess:game/timeout
''')
    clock = ['function chess:system/context',
        'data modify storage chess:runtime clock.wlabel set value "白"',
        'data modify storage chess:runtime clock.blabel set value "黑"',
        'data modify storage chess:runtime clock.wcolor set value "white"',
        'data modify storage chess:runtime clock.bcolor set value "gray"',
        'execute if score @s ch_turn matches 1 run data modify storage chess:runtime clock.wcolor set value "green"',
        'execute if score @s ch_turn matches -1 run data modify storage chess:runtime clock.bcolor set value "green"',
        'data modify storage chess:runtime clock.status set value "白方行棋"',
        'execute if score @s ch_turn matches -1 run data modify storage chess:runtime clock.status set value "黑方行棋"',
        'execute if score @s ch_state matches 2 run data modify storage chess:runtime clock.status set value "走子中"',
        'execute if score @s ch_state matches 3 run data modify storage chess:runtime clock.status set value "选择升变棋子"',
        'execute if score @s ch_state matches 4 run data modify storage chess:runtime clock.status set from entity @s data.chess.result',
    ]
    for level, name in [(1, '简单'), (2, '普通'), (3, '困难')]:
        clock += [f'execute if score @s ch_bot matches 1 if score @s ch_level matches {level} run data modify storage chess:runtime clock.wlabel set value "白·{name}人机"',
                  f'execute if score @s ch_bot matches -1 if score @s ch_level matches {level} run data modify storage chess:runtime clock.blabel set value "黑·{name}人机"']
        clock += [f'execute unless score @s ch_bot matches 0 if score @s ch_level matches {level} if score @s ch_state matches 1 if score @s ch_turn = @s ch_bot run data modify storage chess:runtime clock.status set value "{name}人机思考中"']
    for side in ['w', 'b']:
        clock += [f'scoreboard players operation #seconds ch_ctx = @s ch_{side}time',
            'scoreboard players add #seconds ch_ctx 19', 'scoreboard players operation #seconds ch_ctx /= #twenty ch_ctx',
            'scoreboard players operation #minutes ch_ctx = #seconds ch_ctx', 'scoreboard players operation #minutes ch_ctx /= #sixty ch_ctx',
            'scoreboard players operation #seconds ch_ctx %= #sixty ch_ctx',
            f'execute store result storage chess:runtime clock.{side}m int 1 run scoreboard players get #minutes ch_ctx']
        clock += [f'execute if score #seconds ch_ctx matches {s} run data modify storage chess:runtime clock.{side}s set value "{s:02d}"' for s in range(60)]
    clock += ['execute if score @s ch_time matches 0 run return run function chess:clock/unlimited with storage chess:runtime clock',
              'function chess:clock/timed with storage chess:runtime clock']
    put('clock/update', clock)
    put('clock/timed', '$execute as @e[type=minecraft:text_display,tag=ch.clock] if score @s ct_id = #table ch_ctx run data modify entity @s text set value [{text:"国际象棋 · $(status)\\n",color:"gold"},{text:"$(wlabel) $(wm):$(ws)",color:"$(wcolor)"},{text:"　│　",color:"dark_gray"},{text:"$(blabel) $(bm):$(bs)",color:"$(bcolor)"}]')
    put('clock/unlimited', '$execute as @e[type=minecraft:text_display,tag=ch.clock] if score @s ct_id = #table ch_ctx run data modify entity @s text set value [{text:"国际象棋 · $(status)\\n",color:"gold"},{text:"$(wlabel)　│　$(blabel) · 不限时",color:"gray"}]')
    put('game/timeout', '''
scoreboard players operation #side ch_ctx = @s ch_turn
scoreboard players operation #side ch_ctx *= #minus ch_ctx
function chess:engine/can_mate
scoreboard players set @s ch_result 3
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches 1 run scoreboard players set @s ch_result 1
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches -1 run scoreboard players set @s ch_result 2
scoreboard players set @s ch_reason 6
function chess:game/finish
''')
    put('game/resign', '''
function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1..3 run return 0
scoreboard players operation #side ch_ctx = @e[tag=ch.actor,limit=1] ch_side
scoreboard players operation #side ch_ctx *= #minus ch_ctx
function chess:engine/can_mate
scoreboard players set @s ch_result 3
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches 1 run scoreboard players set @s ch_result 1
execute if score #can_mate ch_ctx matches 1 if score #side ch_ctx matches -1 run scoreboard players set @s ch_result 2
scoreboard players set @s ch_reason 7
function chess:game/finish
''')
    put('game/offer_draw', [
        'function chess:game/actor_guard', 'execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0',
        'execute unless score @s ch_bot matches 0 run return run function chess:game/bot_draw',
        'scoreboard players operation @s ch_draw = @e[tag=ch.actor,limit=1] ch_side',
        'scoreboard players set @s ch_undo 0',
        'scoreboard players add @s ch_epoch 1', say('一方提出和棋，可按 Q 在对局面板中接受或拒绝。'), 'function chess:ui/refresh'])
    put('game/bot_draw', [say('人机同意和棋。'), 'scoreboard players set @s ch_result 3',
        'scoreboard players set @s ch_reason 8', 'function chess:game/finish'])
    put('game/accept_draw', '''
function chess:game/actor_guard
execute unless score #actor_ok ch_ctx matches 1 run return 0
execute unless score @s ch_state matches 1 run return 0
execute if score @s ch_draw matches 0 run return 0
execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_draw run return 0
scoreboard players set @s ch_result 3
scoreboard players set @s ch_reason 8
function chess:game/finish
''')
    put('game/decline_draw', [
        'function chess:game/actor_guard', 'execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0', 'execute if score @s ch_draw matches 0 run return 0',
        'execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_draw run return 0',
        'scoreboard players set @s ch_draw 0', 'scoreboard players add @s ch_epoch 1', say('和棋提议已被拒绝。'), 'function chess:ui/refresh'])
    put('game/claim_draw', [
        'function chess:game/actor_guard', 'execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0',
        'execute unless score @e[tag=ch.actor,limit=1] ch_side = @s ch_turn run return 0',
        'function chess:engine/evaluate',
        'execute if score @s ch_result matches 1..3 run return run function chess:game/finish',
        'execute if score @s ch_repetition matches 3.. run scoreboard players set @s ch_reason 9',
        'execute if score @s ch_half matches 100.. run scoreboard players set @s ch_reason 10',
        'execute unless score @s ch_reason matches 9..10 run ' + say('当前局面尚未满足三次重复或五十回合认领条件。', '@a[tag=ch.actor]', 'red'),
        'execute unless score @s ch_reason matches 9..10 run return 0',
        'scoreboard players set @s ch_result 3', 'function chess:game/finish'])
    # 保存最后一着之前的完整局面。非法尝试只写pending，不覆盖已可悔的上一着。
    undo_scores = ['turn','castle','ep','half','full','wtime','btime','wcapt','bcapt','check','repetition']
    snapshot = ['function chess:system/context',
        'data modify entity @s data.chess.pending_undo set value {board:[]}',
        'data modify entity @s data.chess.pending_undo.history set from entity @s data.chess.history',
        'data modify entity @s data.chess.pending_undo.captured set from entity @s data.chess.captured']
    snapshot += [f'execute store result entity @s data.chess.pending_undo.{field} int 1 run scoreboard players get @s ch_{field}' for field in undo_scores]
    for sq in range(64):
        snapshot += ['data modify entity @s data.chess.pending_undo.board append value 0',
            f'execute store result entity @s data.chess.pending_undo.board[{sq}] int 1 run scoreboard players get @e[type=minecraft:marker,tag=ch.board,scores={{ch_sq={sq}}},limit=1] ch_piece']
    put('game/snapshot', snapshot)
    put('game/offer_undo', [
        'function chess:game/actor_guard', 'execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0',
        'execute unless score @s ch_bot matches 0 run return run function chess:game/bot_undo',
        'execute unless data entity @s data.chess.undo run ' + say('目前没有可撤回的走子。', '@a[tag=ch.actor]', 'red'),
        'execute unless data entity @s data.chess.undo run return 0',
        'scoreboard players operation @s ch_undo = @e[tag=ch.actor,limit=1] ch_side',
        'scoreboard players set @s ch_draw 0', 'scoreboard players add @s ch_epoch 1',
        say('对手申请悔棋，手持对局菜单按 Q 回应。'),
        'function chess:ui/refresh'])
    put('game/bot_undo', [
        'execute unless data entity @s data.chess.ai_undo run ' + say('你还没有可撤回的走子。', '@a[tag=ch.actor]', 'red'),
        'execute unless data entity @s data.chess.ai_undo run return 0',
        'data modify entity @s data.chess.undo set from entity @s data.chess.ai_undo',
        'function chess:game/restore_undo'])
    put('game/decline_undo', [
        'function chess:game/actor_guard','execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0', 'execute if score @s ch_undo matches 0 run return 0',
        'execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_undo run return 0',
        'scoreboard players set @s ch_undo 0', 'scoreboard players add @s ch_epoch 1',
        say('悔棋申请已被拒绝。'), 'function chess:ui/refresh'])
    restore_guard = ['function chess:game/actor_guard','execute unless score #actor_ok ch_ctx matches 1 run return 0',
        'execute unless score @s ch_state matches 1 run return 0', 'execute if score @s ch_undo matches 0 run return 0',
        'execute if score @e[tag=ch.actor,limit=1] ch_side = @s ch_undo run return 0',
        'execute unless data entity @s data.chess.undo run return 0']
    put('game/accept_undo', restore_guard + ['function chess:game/restore_undo'])
    restore = ['function chess:ai/reset']
    restore += [f'execute store result score @s ch_{field} run data get entity @s data.chess.undo.{field}' for field in undo_scores]
    restore += ['data modify entity @s data.chess.history set from entity @s data.chess.undo.history',
        'data modify entity @s data.chess.captured set from entity @s data.chess.undo.captured',
        'data modify storage chess:undo saved set from entity @s data.chess.undo']
    for sq in range(64):
        restore += [f'execute store result score #restore ch_ctx run data get storage chess:undo saved.board[{sq}]',
                    f'scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={{ch_sq={sq}}},limit=1] ch_piece = #restore ch_ctx']
    restore += ['data remove entity @s data.chess.undo', 'data remove entity @s data.chess.pending_undo',
        'data remove entity @s data.chess.ai_undo',
        'data remove entity @s data.chess.last', 'data remove storage chess:undo saved',
        'scoreboard players set @s ch_undo 0','scoreboard players set @s ch_draw 0',
        'scoreboard players set @s ch_sel -1','scoreboard players set @s ch_result 0','scoreboard players set @s ch_reason 0',
        'scoreboard players add @s ch_epoch 1', 'function chess:visual/refresh', 'function chess:clock/update',
        'function chess:ui/refresh',
        'execute if score @s ch_bot matches 0 run ' + say('对手同意悔棋，已撤回最后一步，并恢复该步之前的局面与时钟。'),
        'execute unless score @s ch_bot matches 0 run ' + say('人机同意悔棋，已恢复到你上次走子之前的局面与时钟。')]
    put('game/restore_undo', restore)
    reasons = {1:'将死',2:'无合法走法且未被将军',3:'常见子力不足',4:'五次重复局面',5:'七十五回合未动兵或吃子',6:'超时',7:'认输',8:'双方同意和棋',9:'认领三次重复局面',10:'认领五十回合未动兵或吃子',11:'棋盘数据不完整或异常'}
    finish = ['function chess:system/context',
              'function chess:ai/reset',
              'execute unless score @s ch_state matches 4 run function chess:sound/end',
              'scoreboard players set @s ch_state 4', 'scoreboard players set @s ch_timer 100',
              'scoreboard players set @s ch_sel -1', 'scoreboard players set @s ch_draw 0', 'scoreboard players set @s ch_undo 0', 'scoreboard players add @s ch_epoch 1',
              'function chess:visual/finish_move', 'function chess:visual/select',
              'data modify entity @s data.chess.result set value "和棋"',
              'execute if score @s ch_result matches 1 run data modify entity @s data.chess.result set value "白方获胜"',
              'execute if score @s ch_result matches 2 run data modify entity @s data.chess.result set value "黑方获胜"',
              'data modify storage chess:runtime result.title set from entity @s data.chess.result',
              'data modify storage chess:runtime result.reason set value "对局结束"']
    finish += [f'execute if score @s ch_reason matches {n} run data modify storage chess:runtime result.reason set value "{reason}"' for n,reason in reasons.items()]
    finish += ['function chess:game/result_text with storage chess:runtime result', 'function chess:clock/update', 'function chess:ui/refresh', 'function chess:log {text:"对局结束，五秒后返回大厅"}']
    put('game/finish', finish)
    put('game/result_text', '$tellraw @a[tag=ch.audience] [{text:"[国际象棋] $(title)",color:"gold",bold:true},{text:"：$(reason)。五秒后返回大厅。",color:"yellow"}]')
    put('game/result_tick', '''
scoreboard players remove @s ch_timer 1
execute if score @s ch_timer matches ..0 run function chess:game/cleanup
''')
    put('player/clear_state', '''
function chess:input/clear
scoreboard players reset @s ch_table
scoreboard players reset @s ch_side
scoreboard players reset @s ch_seat
scoreboard players reset @s ch_weight
tag @s remove ch.player
tag @s remove ch.audience
''')
    put('game/cleanup', '''
# 返回大厅并保留终局棋面，清除计时和输入；再次开局或切换游戏才重摆。
scoreboard players set @s ch_state 0
scoreboard players set @s ch_sel -1
scoreboard players set @s ch_draw 0
scoreboard players set @s ch_undo 0
data modify entity @s data.chess.review set value 1b
function chess:ai/reset
function chess:system/context
function chess:visual/finish_move
function chess:visual/select
execute as @e[type=minecraft:text_display,tag=ch.clock] if score @s ct_id = #table ch_ctx run kill @s
execute as @a[tag=ch.player] if score @s ch_table = #table ch_ctx run function chess:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}] run function chess:player/kill_drop
function cardtable:game/return_lobby
''')
    put('player/kill_drop', '''
execute store result score #drop_table ch_ctx run data get entity @s Item.components."minecraft:custom_data".chess.table
execute if score #drop_table ch_ctx = #table ch_ctx run kill @s
''')
    put('game/remove', '''
# 切换游戏/删除牌桌专用：不重新生成预览，不更改即将选中的游戏。
function chess:settings/invalidate_table
function chess:ai/reset
data remove entity @s data.chess.review
function chess:system/context
execute as @a[tag=ch.player] if score @s ch_table = #table ch_ctx run function chess:player/clear_state
function chess:visual/clear
kill @e[type=minecraft:marker,tag=ch.board]
tag @s remove ch.controller
tag @s remove ch.current
scoreboard players set @s ch_state 0
''')
    put('game/abort', ['execute unless entity @s[tag=ch.controller] run return fail', 'function chess:system/context', say('本场已中止，牌桌返回大厅。'), 'function chess:game/cleanup'])
    put('game/end_vote', ['execute unless entity @s[tag=ch.controller] run return fail', 'function chess:system/context', say('结束投票通过，本场提前结束。'), 'function chess:game/cleanup'])
    put('admin/abort', '''
# 可直接 /function 调用；只处理同维度八格内最近的一场国际象棋。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ch.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[国际象棋] 同维度 8 格内没有正在运行的国际象棋牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ch.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ch.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function chess:game/abort
''')
    put('log', '$tellraw @a[tag=ct.debug] [{text:"[国际象棋 Debug] $(text)",color:"gray"}]')
    print('Generated chess lifecycle / clock / admin functions.')


if __name__ == '__main__':
    main()
