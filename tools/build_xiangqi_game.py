"""生成中国象棋生命周期、计时及通用牌桌接入外的游戏函数。

规则/UI/模型分别由 build_xiangqi_engine/ui/visual.py 维护。运行本脚本只更新
xiangqi 的 load/tick/system/game/player/admin/clock/log，不重写其他模块。
"""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1] / 'data/xiangqi/function'


def put(name, lines):
    target = ROOT / (name + '.mcfunction')
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')


def say(text, target='@a[tag=xq.audience]', color='yellow'):
    return 'tellraw ' + target + ' ' + json.dumps({'text': '[中国象棋] ' + text, 'color': color}, ensure_ascii=False)


def main():
    from build_xiangqi_sound import build as build_sound
    build_sound(ROOT)
    from build_xiangqi_ai import build as build_ai
    build_ai(ROOT)
    dummy = '''xq_ctx xq_state xq_sq xq_piece xq_turn xq_half xq_full
xq_epoch xq_result xq_reason xq_check xq_repetition xq_sel xq_timer
xq_red xq_black xq_table xq_side xq_seat xq_weight xq_rtime xq_btime xq_board xq_palette
xq_orient xq_time xq_draw xq_pulse xq_owner xq_slot xq_rcapt xq_bcapt
xq_seen xq_ui_load xq_ui_tmp xq_set_table xq_setnonce xq_setepoch xq_nonce xq_first xq_undo
xq_bot xq_level xq_hints xq_aistate xq_aiwait xq_aiepoch'''.split()
    put('system/install', [f'scoreboard objectives add {o} dummy' for o in dummy if o != 'xq_ctx'] + [
        'scoreboard objectives add xq_action trigger', 'scoreboard objectives add xq_settings trigger',
        'scoreboard objectives add xq_drop minecraft.dropped:minecraft.paper',
        'scoreboard players set #version xq_ctx 1'])


    put('load', '''
scoreboard objectives add xq_ctx dummy
execute unless score #version xq_ctx matches 1.. run function xiangqi:system/install
execute as @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller] unless data entity @s data.xiangqi{palette_version:2b} run function xiangqi:system/migrate_palette
# 分边默认按座位（1）；合法的显式随机（0）保留，旧指定座位值迁为默认。
execute as @e[tag=xq.controller] unless score @s xq_first matches 0..1 run scoreboard players set @s xq_first 1
scoreboard players set #minus xq_ctx -1
scoreboard players set #two xq_ctx 2
scoreboard players set #four xq_ctx 4
scoreboard players set #eight xq_ctx 8
scoreboard players set #nine xq_ctx 9
scoreboard players set #ten xq_ctx 10
scoreboard players set #twenty xq_ctx 20
scoreboard players set #sixty xq_ctx 60
scoreboard players set #thousand xq_ctx 1000
execute unless score #setting_serial xq_ctx matches 100000..999999 run scoreboard players set #setting_serial xq_ctx 99999
scoreboard players add #ui_load xq_ctx 1
scoreboard players reset * xq_action
scoreboard players reset * xq_settings
scoreboard players reset * xq_setnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=13}] at @s run function xiangqi:system/reload
''')
    put('system/context', '''
# 每个入口重新绑定桌号；规则/交互均不依赖“最近实体”。
scoreboard players operation #table xq_ctx = @s ct_id
tag @e[tag=xq.current] remove xq.current
tag @e[tag=xq.board] remove xq.board
tag @a[tag=xq.audience] remove xq.audience
tag @e[tag=xq.audience] remove xq.audience
tag @s add xq.current
execute as @e[type=minecraft:marker,tag=xq.square] if score @s ct_id = #table xq_ctx run tag @s add xq.board
execute as @e[tag=xq.player,tag=ct.player] if score @s xq_table = #table xq_ctx if score @s ct_id = #table xq_ctx run tag @s add xq.audience
''')
    put('game/init_table', '''
tag @s add xq.controller
execute unless data entity @s data.xiangqi{palette_version:2b} run function xiangqi:system/migrate_palette
execute unless score @s xq_board matches 0..1 run scoreboard players set @s xq_board 0
execute unless score @s xq_palette matches 0..1 run scoreboard players set @s xq_palette 0
execute unless score @s xq_orient matches 0..1 run scoreboard players set @s xq_orient 0
execute unless score @s xq_time matches 0..30 run scoreboard players set @s xq_time 10
execute unless score @s xq_first matches 0..1 run scoreboard players set @s xq_first 1
execute unless score @s xq_level matches 1..3 run scoreboard players set @s xq_level 2
execute unless score @s xq_hints matches 0..1 run scoreboard players set @s xq_hints 1
execute unless score @s xq_bot matches -1..1 run scoreboard players set @s xq_bot 0
execute unless score @s xq_epoch matches 1.. run scoreboard players set @s xq_epoch 1
execute if score @s ct_state matches 0 run function xiangqi:game/preview
''')
    put('system/migrate_palette', '''
# 旧版棋盘 2 为木色、1 为竹绿；按桌迁移，活跃棋局及其他设置不变。
execute if score @s xq_board matches 1 run scoreboard players set @s xq_board 0
execute if score @s xq_board matches 2 run scoreboard players set @s xq_board 1
execute unless score @s xq_board matches 0..1 run scoreboard players set @s xq_board 0
execute unless score @s xq_palette matches 0..1 run scoreboard players set @s xq_palette 0
data modify entity @s data.xiangqi.palette_version set value 2b
''')
    put('system/create_board', [
        'function xiangqi:system/context', 'kill @e[type=minecraft:marker,tag=xq.board]',
    ] + [f'execute summon minecraft:marker run function xiangqi:system/square {{sq:{sq}}}' for sq in range(90)] + ['function xiangqi:system/context'])
    put('system/square', '''
tag @s add xq.square
scoreboard players operation @s ct_id = #table xq_ctx
$scoreboard players set @s xq_sq $(sq)
scoreboard players set @s xq_piece 0
''')
    put('game/preview', '''
# 选择游戏或改变外观后立即显示；绝不重置进行中的对局。
execute unless score @s ct_game matches 13 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.xiangqi{review:1b} run return run function xiangqi:game/review
tag @s add xq.controller
scoreboard players set @s xq_state 0
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_timer 0
scoreboard players set @s xq_pulse 0
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
scoreboard players set @s xq_bot 0
function xiangqi:ai/reset
data remove entity @s data.xiangqi.ai_undo
data remove entity @s data.xiangqi.undo
data remove entity @s data.xiangqi.pending_undo
scoreboard players add @s xq_epoch 1
function xiangqi:visual/clear
function xiangqi:system/create_board
function xiangqi:engine/init_board
function xiangqi:visual/setup
''')
    put('game/review', '''
# 大厅保留终局棋面；重载或修改配色只重建展示，不初始化规则局面。
execute unless score @s ct_game matches 13 run return 0
execute unless score @s ct_state matches 0 run return 0
function xiangqi:system/context
scoreboard players set @s xq_state 0
scoreboard players set @s xq_sel -1
scoreboard players add @s xq_epoch 1
function xiangqi:ai/reset
function xiangqi:visual/refresh
''')
    put('system/reload', '''
tag @s add xq.controller
execute if score @s ct_state matches 0 run return run function xiangqi:game/init_table
function xiangqi:system/context
scoreboard players add @s xq_epoch 1
function xiangqi:ai/reset
# 保留阵营，恢复对应桌边与通用座位身份；不重新随机或重置棋局。
function xiangqi:game/reseat
# 棋面、重复判定历史和时钟均保留；重建的只是展示实体。
function xiangqi:visual/refresh
function xiangqi:clock/create
execute as @a[tag=xq.audience] run function xiangqi:input/give
function xiangqi:ui/refresh
''')
    put('game/start', [
        'function xiangqi:game/init_table',
        'execute unless score @s ct_joined matches 1..2 run ' + say('中国象棋支持一至两名玩家，单人自动匹配人机。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute unless score @s ct_joined matches 1..2 run return fail',
        'function xiangqi:system/context', 'scoreboard players set #online xq_ctx 0', 'scoreboard players set #blocked xq_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx run scoreboard players add #online xq_ctx 1',
        *[f'execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx if items entity @s hotbar.{slot} * unless items entity @s hotbar.{slot} minecraft:paper[minecraft:custom_data~{{xiangqi:{{tool:1b}}}}] run scoreboard players set #blocked xq_ctx 1' for slot in (8,)],
        'execute unless score #online xq_ctx = @s ct_joined run ' + say('入座的玩家都需要在线。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute unless score #online xq_ctx = @s ct_joined run return fail',
        'execute if score #blocked xq_ctx matches 1 run ' + say('请先清空快捷栏最后一格（第9格）。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute if score #blocked xq_ctx matches 1 run return fail',
        'function xiangqi:system/side_seats',
        'scoreboard players set #red_ready xq_ctx 0',
        'scoreboard players set #black_ready xq_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx run function xiangqi:player/seat_side',
        'execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx if score @s xq_weight matches 1 run scoreboard players add #red_ready xq_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx if score @s xq_weight matches -1 run scoreboard players add #black_ready xq_ctx 1',
        'execute if score @s xq_first matches 1 run function xiangqi:game/check_sides',
        'execute if score @s xq_first matches 1 if score #side_ok xq_ctx matches 0 run function xiangqi:game/seat_hint',
        'execute if score @s xq_first matches 1 if score #side_ok xq_ctx matches 0 run return fail',
        'execute as @a[tag=ct.player] if score @s ct_id = #table xq_ctx run function xiangqi:player/init',
        'function xiangqi:system/context', 'function xiangqi:game/assign_sides',
        'execute store result score #seats_ok xq_ctx run function xiangqi:game/reseat',
        'execute unless score #seats_ok xq_ctx matches 1 run return run function xiangqi:game/abort',
        'function xiangqi:ai/reset', 'data remove entity @s data.xiangqi.ai_undo',
        'function xiangqi:settings/invalidate_table',
        'data remove entity @s data.xiangqi.review',
        'scoreboard players set @s xq_state 1', 'scoreboard players set @s xq_sel -1',
        'scoreboard players set @s xq_timer 0', 'scoreboard players set @s xq_pulse 0', 'scoreboard players set @s xq_draw 0',
        'scoreboard players add @s xq_epoch 1', 'function xiangqi:engine/init_board', 'function xiangqi:visual/setup',
        'scoreboard players operation @s xq_rtime = @s xq_time',
        'scoreboard players set #minute xq_ctx 1200', 'scoreboard players operation @s xq_rtime *= #minute xq_ctx',
        'scoreboard players operation @s xq_btime = @s xq_rtime',
        'execute as @a[tag=xq.audience] run function xiangqi:input/give',
        'scoreboard players set @s ct_start 1', 'function xiangqi:clock/create', 'function xiangqi:ui/refresh',
        'function xiangqi:sound/start',
        say('红方先行。右键选子、落子；手持最后一格的对局菜单按 Q。'),
        'function xiangqi:game/announce_sides',
        'function xiangqi:log {text:"对局开始"}',
    ])
    put('player/init', '''
tag @s add xq.player
scoreboard players operation @s xq_table = @s ct_id
scoreboard players operation @s xq_seat = @s ct_seat
scoreboard players set @s xq_side -1
scoreboard players set @s xq_seen -1
''')
    # 红方始终先行；这里只决定谁执红，阵营再决定实际座位。
    put('game/check_sides', '''
scoreboard players set #side_ok xq_ctx 0
execute if score @s ct_joined matches 2 if score #red_ready xq_ctx matches 1 if score #black_ready xq_ctx matches 1 run scoreboard players set #side_ok xq_ctx 1
execute if score @s ct_joined matches 1 if score #red_ready xq_ctx matches 1 run scoreboard players set #side_ok xq_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready xq_ctx matches 1 run scoreboard players set #side_ok xq_ctx 1
''')
    put('game/assign_sides', '''
scoreboard players set @s xq_bot 0
execute if score @s ct_joined matches 1 run return run function xiangqi:game/solo_sides
execute if score @s xq_first matches 0 run function xiangqi:game/random_first
execute if score @s xq_first matches 1 run function xiangqi:game/chosen_first
''')
    put('game/solo_sides', '''
# 单人也保留入座选边／随机红黑的规则，人机是虚拟对手，不创建假玩家。
scoreboard players set #human_side xq_ctx 1
execute if score @s xq_first matches 0 store result score #human_side xq_ctx run random value 0..1
execute if score #human_side xq_ctx matches 0 run scoreboard players set #human_side xq_ctx -1
execute if score @s xq_first matches 1 run scoreboard players operation #human_side xq_ctx = @a[tag=xq.audience,limit=1] xq_weight
scoreboard players operation @a[tag=xq.audience,limit=1] xq_side = #human_side xq_ctx
scoreboard players operation @s xq_bot = #human_side xq_ctx
scoreboard players operation @s xq_bot *= #minus xq_ctx
''')
    put('game/random_first', '''
scoreboard players set @a[tag=xq.audience] xq_side -1
scoreboard players set @a[tag=xq.audience,sort=random,limit=1] xq_side 1
''')
    put('game/chosen_first', '''
scoreboard players set @a[tag=xq.audience] xq_side -1
execute as @a[tag=xq.audience] if score @s xq_weight matches 1 run scoreboard players set @s xq_side 1
''')
    announce_sides = [
        'data modify storage xiangqi:runtime sides.red set value {selector:"@a[tag=xq.audience,scores={xq_side=1}]"}',
        'data modify storage xiangqi:runtime sides.black set value {selector:"@a[tag=xq.audience,scores={xq_side=-1}]"}',
    ]
    for level, name in [(1, '简单'), (2, '普通'), (3, '困难')]:
        for side, field in [(1, 'red'), (-1, 'black')]:
            announce_sides += [f'execute if score @s xq_bot matches {side} if score @s xq_level matches {level} run data modify storage xiangqi:runtime sides.{field} set value {{text:"{name}人机",color:"aqua"}}']
    announce_sides += ['function xiangqi:game/announce_sides_text with storage xiangqi:runtime sides']
    put('game/announce_sides', announce_sides)
    put('game/announce_sides_text', '$tellraw @a[tag=xq.audience] [{text:"[中国象棋] 红方：",color:"red"},$(red),{text:"　黑方：",color:"gray"},$(black)]')
    sides = {(4, 0): ((3, 3), (1, 1)), (4, 1): ((4, 4), (2, 2)),
             (8, 0): ((5, 6), (1, 2)), (8, 1): ((7, 8), (3, 4))}
    side_seats = ['scoreboard players operation #cap xq_ctx = @s ct_capacity',
                  'scoreboard players operation #orient xq_ctx = @s xq_orient']
    seat_side = ['scoreboard players set @s xq_weight 0']
    hints = []
    for (cap, orient), (red, black) in sides.items():
        guard = f'execute if score #cap xq_ctx matches {cap} if score #orient xq_ctx matches {orient}'
        for name, seats, side in [('red', red, 1), ('black', black, -1)]:
            for bound, value in [('seat', seats[0]), ('last', seats[1])]:
                side_seats.append(f'{guard} run scoreboard players set #{name}_{bound} xq_ctx {value}')
            seat_range = str(seats[0]) if seats[0] == seats[1] else f'{seats[0]}..{seats[1]}'
            seat_side.append(f'{guard} if score @s ct_seat matches {seat_range} run scoreboard players set @s xq_weight {side}')
        def seats_text(bounds):
            return str(bounds[0]) if bounds[0] == bounds[1] else f'{bounds[0]}／{bounds[1]}'
        hints.append(guard + ' run ' + say(f'自行选边时，请坐红方侧 {seats_text(red)} 号位或黑方侧 {seats_text(black)} 号位；双人局须两侧各一人，也可改用随机红黑。', '@a[tag=ct.start_actor,limit=1]', 'red'))
    put('system/side_seats', side_seats)
    put('player/seat_side', seat_side)
    put('player/weight', 'function xiangqi:player/seat_side')
    put('game/seat_hint', hints)
    put('game/reseat', '''
# 先冻结双方目标座位，再全部下座、统一更新身份，最后按阵营分别骑乘。
# 不让尚未执行的玩家继续占用另一方目标，也不让临时选择器跨玩家串位。
function xiangqi:system/context
function xiangqi:system/side_seats
scoreboard players set #red_ready xq_ctx 0
scoreboard players set #black_ready xq_ctx 0
execute as @a[tag=xq.audience,scores={xq_side=1}] run scoreboard players add #red_ready xq_ctx 1
execute as @a[tag=xq.audience,scores={xq_side=-1}] run scoreboard players add #black_ready xq_ctx 1
execute if score @s xq_bot matches 1 run scoreboard players add #red_ready xq_ctx 1
execute if score @s xq_bot matches -1 run scoreboard players add #black_ready xq_ctx 1
execute unless score #red_ready xq_ctx matches 1 run return 0
execute unless score #black_ready xq_ctx matches 1 run return 0
execute as @a[tag=xq.audience] run function xiangqi:player/place_side
execute as @a[tag=xq.audience] run ride @s dismount
execute as @a[tag=xq.audience] run scoreboard players operation @s ct_seat = @s xq_seat
# 虚拟对手同样占用对应边的逻辑座号，供吃子区朝向和阵营显示使用。
scoreboard players operation @s xq_red = #red_seat xq_ctx
scoreboard players operation @s xq_black = #black_seat xq_ctx
execute unless score @s xq_bot matches 1 run scoreboard players operation @s xq_red = @a[tag=xq.audience,scores={xq_side=1},limit=1] xq_seat
execute unless score @s xq_bot matches -1 run scoreboard players operation @s xq_black = @a[tag=xq.audience,scores={xq_side=-1},limit=1] xq_seat
function cardtable:table/ensure_seats
scoreboard players set #seats_ok xq_ctx 1
execute as @a[tag=xq.audience,scores={xq_side=1},limit=1] at @s run function xiangqi:player/mount_side
execute as @a[tag=xq.audience,scores={xq_side=-1},limit=1] at @s run function xiangqi:player/mount_side
return run scoreboard players get #seats_ok xq_ctx
''')
    put('player/place_side', '''
# 只计算目标，暂不修改通用座位，避免双方互换时出现中间的同座身份。
scoreboard players operation @s xq_seat = @s ct_seat
execute if score @s xq_side matches 1 if score @s xq_seat < #red_seat xq_ctx run scoreboard players operation @s xq_seat = #red_seat xq_ctx
execute if score @s xq_side matches 1 if score @s xq_seat > #red_last xq_ctx run scoreboard players operation @s xq_seat = #red_seat xq_ctx
execute if score @s xq_side matches -1 if score @s xq_seat < #black_seat xq_ctx run scoreboard players operation @s xq_seat = #black_seat xq_ctx
execute if score @s xq_side matches -1 if score @s xq_seat > #black_last xq_ctx run scoreboard players operation @s xq_seat = #black_seat xq_ctx
''')
    put('player/mount_side', '''
# 每一方单独完成通用骑乘及核验，再处理下一方；不共享待骑乘目标。
function cardtable:seat/mount
scoreboard players operation #mount_seat xq_ctx = @s xq_seat
scoreboard players set #mounted xq_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table xq_ctx if score @s ct_seat = #mount_seat xq_ctx run scoreboard players set #mounted xq_ctx 1
execute unless score #mounted xq_ctx matches 1 run scoreboard players set #seats_ok xq_ctx 0
''')
    put('game/actor_guard', '''
# 供控制器回调复用；UI有nonce校验，此处仍复核真人/桌号/身份。
function xiangqi:system/context
scoreboard players set #actor_ok xq_ctx 0
execute as @e[tag=xq.actor,tag=xq.audience,limit=1] if score @s xq_table = #table xq_ctx run scoreboard players set #actor_ok xq_ctx 1
''')
    put('game/click', [
        'function xiangqi:game/actor_guard', 'execute unless score #actor_ok xq_ctx matches 1 run return 0',
        'execute unless score @s xq_state matches 1 run return 0',
        'execute unless score @e[tag=xq.actor,limit=1] xq_side = @s xq_turn run return 0',
        'execute unless score #target xq_ctx matches 0..89 run return 0',
        'scoreboard players set #chosen xq_ctx 0',
        'execute as @e[type=minecraft:marker,tag=xq.board] if score @s xq_sq = #target xq_ctx run scoreboard players operation #chosen xq_ctx = @s xq_piece',
        'scoreboard players operation #chosen xq_ctx *= @s xq_turn',
        'execute if score #chosen xq_ctx matches 1..7 run return run function xiangqi:game/select',
        'execute if score @s xq_sel matches -1 run return 0',
        'scoreboard players operation #from xq_ctx = @s xq_sel', 'scoreboard players operation #to xq_ctx = #target xq_ctx',
        'function xiangqi:game/snapshot', 'function xiangqi:engine/try_move',
        'execute if score #legal xq_ctx matches 0 run function xiangqi:game/illegal',
    ])
    put('game/select', [
        'scoreboard players set #chosen xq_ctx 0',
        'execute as @e[type=minecraft:marker,tag=xq.board] if score @s xq_sq = #target xq_ctx run scoreboard players operation #chosen xq_ctx = @s xq_piece',
        'scoreboard players operation #chosen xq_ctx *= @s xq_turn',
        'execute unless score #chosen xq_ctx matches 1..7 run return 0',
        'scoreboard players operation @s xq_sel = #target xq_ctx', 'function xiangqi:visual/select',
        *[f'execute if score #chosen xq_ctx matches {kind} run title @a[tag=xq.actor] actionbar {{text:"已选择：{name}",color:"gold"}}' for kind,name in enumerate(['','兵／卒','马','相／象','车','炮','帅／将','仕／士']) if kind],
    ])
    put('game/illegal', ['scoreboard players set @s xq_sel -1', 'function xiangqi:visual/select', 'function xiangqi:sound/illegal', say('这一步不合法，请重新选择棋子。', '@a[tag=xq.actor]', 'red')])


    put('game/after_move', '''
# engine已原子提交棋面和轮次，此处只读last，随后锁输入到插值结束。
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
data modify entity @s data.xiangqi.undo set from entity @s data.xiangqi.pending_undo
data remove entity @s data.xiangqi.pending_undo
# 单人悔棋保留真人提交前的快照，可连同人机应手撤回到真人回合。
execute store result score #moved_piece xq_ctx run data get entity @s data.xiangqi.last.piece
execute if score @s xq_bot matches 1 if score #moved_piece xq_ctx matches ..-1 run data modify entity @s data.xiangqi.ai_undo set from entity @s data.xiangqi.undo
execute if score @s xq_bot matches -1 if score #moved_piece xq_ctx matches 1.. run data modify entity @s data.xiangqi.ai_undo set from entity @s data.xiangqi.undo
function xiangqi:ai/reset
scoreboard players add @s xq_epoch 1
function xiangqi:visual/move
function xiangqi:game/announce_move
function xiangqi:engine/evaluate
scoreboard players set @s xq_state 2
scoreboard players set @s xq_timer 8
function xiangqi:clock/update
function xiangqi:ui/refresh
function xiangqi:log {text:"合法走子已提交，开始走子/吃子动画"}
scoreboard players set #legal xq_ctx 1
''')
    announce = ['execute store result score #log_from xq_ctx run data get entity @s data.xiangqi.last.from',
                'execute store result score #log_to xq_ctx run data get entity @s data.xiangqi.last.to',
                'execute store result score #log_piece xq_ctx run data get entity @s data.xiangqi.last.piece',
                'execute store result score #log_cap xq_ctx run data get entity @s data.xiangqi.last.captured',
                'data modify storage xiangqi:runtime move.side set value "红方"',
                'execute if score #log_piece xq_ctx matches ..-1 run data modify storage xiangqi:runtime move.side set value "黑方"',
                'execute if score #log_piece xq_ctx matches ..-1 run scoreboard players operation #log_piece xq_ctx *= #minus xq_ctx',
                'data modify storage xiangqi:runtime move.extra set value ""',
                'execute unless score #log_cap xq_ctx matches 0 run data modify storage xiangqi:runtime move.extra set value "（吃子）"']
    for v, name in enumerate(['', '兵／卒', '马', '相／象', '车', '炮', '帅／将', '仕／士']):
        if v:
            announce += [f'execute if score #log_piece xq_ctx matches {v} run data modify storage xiangqi:runtime move.piece set value "{name}"']
    for sq in range(90):
        coord = chr(97 + sq % 9) + str(sq // 9 + 1)
        for field in ['from', 'to']:
            announce.append(f'execute if score #log_{field} xq_ctx matches {sq} run data modify storage xiangqi:runtime move.{field} set value "{coord}"')
    announce += ['function xiangqi:game/announce_text with storage xiangqi:runtime move']
    put('game/announce_move', announce)
    put('game/announce_text', '$tellraw @a[tag=xq.audience] [{text:"[中国象棋] ",color:"gold"},{text:"$(side) $(piece) $(from) → $(to)$(extra)",color:"red"}]')
    put('tick', '''
function xiangqi:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=13},tag=!xq.controller] at @s run function xiangqi:game/init_table
execute as @e[type=minecraft:marker,tag=xq.controller,scores={ct_game=13}] at @s run function xiangqi:system/tick
''')
    put('system/tick', '''
scoreboard players add @s xq_pulse 1
execute if score @s xq_state matches 1 run function xiangqi:clock/tick
execute if score @s xq_state matches 2 run function xiangqi:game/animate_tick
execute if score @s xq_state matches 4 run function xiangqi:game/result_tick
execute if score @s xq_state matches 1 run function xiangqi:ai/tick
execute if score @s xq_pulse matches 20.. run function xiangqi:system/heartbeat
''')
    put('system/heartbeat', '''
scoreboard players set @s xq_pulse 0
function xiangqi:system/context
execute if score @s ct_state matches 0 unless entity @e[type=minecraft:interaction,tag=xq.cell,scores={ct_id=0}] run function xiangqi:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online xq_ctx 0
execute as @a[tag=xq.audience] run scoreboard players add #online xq_ctx 1
scoreboard players set #expected xq_ctx 2
execute unless score @s xq_bot matches 0 run scoreboard players set #expected xq_ctx 1
execute unless score #online xq_ctx = #expected xq_ctx run return run function xiangqi:game/abort
function xiangqi:clock/update
'''.replace(' unless entity @e[type=minecraft:interaction,tag=xq.cell,scores={ct_id=0}]',''))
    put('system/check_visual', '''
scoreboard players set #has_visual xq_ctx 0
execute as @e[type=minecraft:interaction,tag=xq.cell] if score @s ct_id = #table xq_ctx run scoreboard players set #has_visual xq_ctx 1
execute if score #has_visual xq_ctx matches 0 run function xiangqi:game/preview
''')
    put('game/animate_tick', '''
scoreboard players remove @s xq_timer 1
execute if score @s xq_timer matches ..0 run function xiangqi:game/animation_done
''')
    put('game/animation_done', [
        'function xiangqi:visual/finish_move',
        'execute if score @s xq_result matches 1..3 run return run function xiangqi:game/finish',
        'function xiangqi:sound/landing',
        'scoreboard players set @s xq_state 1', 'function xiangqi:clock/update', 'function xiangqi:ui/refresh',
        'execute if score @s xq_check matches 1 run ' + say('将军！轮到的一方必须解除将军。', color='red')])
    put('clock/create', '''
function xiangqi:system/context
execute as @e[type=minecraft:text_display,tag=xq.clock] if score @s ct_id = #table xq_ctx run kill @s
execute positioned ~ ~3.00 ~ summon minecraft:text_display run function xiangqi:clock/entity
function xiangqi:clock/update
''')
    put('clock/entity', '''
tag @s add xq.clock
tag @s add xq.visual
scoreboard players operation @s ct_id = #table xq_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:300,background:0,shadow:1b,see_through:0b,view_range:24f,text:{text:"中国象棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
''')
    put('clock/tick', '''
execute if score @s xq_time matches 0 run return 0
execute if score @s xq_turn matches 1 run scoreboard players remove @s xq_rtime 1
execute if score @s xq_turn matches -1 run scoreboard players remove @s xq_btime 1
execute if score @s xq_turn matches 1 if score @s xq_rtime matches ..0 run function xiangqi:game/timeout
execute if score @s xq_turn matches -1 if score @s xq_btime matches ..0 run function xiangqi:game/timeout
''')
    clock = ['function xiangqi:system/context',
        'data modify storage xiangqi:runtime clock.rlabel set value "红"',
        'data modify storage xiangqi:runtime clock.blabel set value "黑"',
        'data modify storage xiangqi:runtime clock.rcolor set value "red"',
        'data modify storage xiangqi:runtime clock.bcolor set value "gray"',
        'execute if score @s xq_turn matches 1 run data modify storage xiangqi:runtime clock.rcolor set value "green"',
        'execute if score @s xq_turn matches -1 run data modify storage xiangqi:runtime clock.bcolor set value "green"',
        'data modify storage xiangqi:runtime clock.status set value "红方行棋"',
        'execute if score @s xq_turn matches -1 run data modify storage xiangqi:runtime clock.status set value "黑方行棋"',
        'execute if score @s xq_state matches 2 run data modify storage xiangqi:runtime clock.status set value "走子中"',
        'execute if score @s xq_state matches 4 run data modify storage xiangqi:runtime clock.status set from entity @s data.xiangqi.result',
    ]
    for level, name in [(1, '简单'), (2, '普通'), (3, '困难')]:
        clock += [f'execute if score @s xq_bot matches 1 if score @s xq_level matches {level} run data modify storage xiangqi:runtime clock.rlabel set value "红·{name}人机"',
                  f'execute if score @s xq_bot matches -1 if score @s xq_level matches {level} run data modify storage xiangqi:runtime clock.blabel set value "黑·{name}人机"']
        clock += [f'execute unless score @s xq_bot matches 0 if score @s xq_level matches {level} if score @s xq_state matches 1 if score @s xq_turn = @s xq_bot run data modify storage xiangqi:runtime clock.status set value "{name}人机思考中"']
    for side in ['r', 'b']:
        clock += [f'scoreboard players operation #seconds xq_ctx = @s xq_{side}time',
            'scoreboard players add #seconds xq_ctx 19', 'scoreboard players operation #seconds xq_ctx /= #twenty xq_ctx',
            'scoreboard players operation #minutes xq_ctx = #seconds xq_ctx', 'scoreboard players operation #minutes xq_ctx /= #sixty xq_ctx',
            'scoreboard players operation #seconds xq_ctx %= #sixty xq_ctx',
            f'execute store result storage xiangqi:runtime clock.{side}m int 1 run scoreboard players get #minutes xq_ctx']
        clock += [f'execute if score #seconds xq_ctx matches {s} run data modify storage xiangqi:runtime clock.{side}s set value "{s:02d}"' for s in range(60)]
    clock += ['execute if score @s xq_time matches 0 run return run function xiangqi:clock/unlimited with storage xiangqi:runtime clock',
              'function xiangqi:clock/timed with storage xiangqi:runtime clock']
    put('clock/update', clock)
    put('clock/timed', '$execute as @e[type=minecraft:text_display,tag=xq.clock] if score @s ct_id = #table xq_ctx run data modify entity @s text set value [{text:"中国象棋 · $(status)\\n",color:"gold"},{text:"$(rlabel) $(rm):$(rs)",color:"$(rcolor)"},{text:"　│　",color:"dark_gray"},{text:"$(blabel) $(bm):$(bs)",color:"$(bcolor)"}]')
    put('clock/unlimited', '$execute as @e[type=minecraft:text_display,tag=xq.clock] if score @s ct_id = #table xq_ctx run data modify entity @s text set value [{text:"中国象棋 · $(status)\\n",color:"gold"},{text:"$(rlabel)　│　$(blabel) · 不限时",color:"gray"}]')
    put('game/timeout', '''
function xiangqi:system/context
scoreboard players operation #side xq_ctx = @s xq_turn
scoreboard players operation #side xq_ctx *= #minus xq_ctx
scoreboard players set @s xq_result 2
execute if score #side xq_ctx matches 1 run scoreboard players set @s xq_result 1
scoreboard players set @s xq_reason 6
function xiangqi:game/finish
''')
    put('game/resign', '''
function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1..2 run return 0
scoreboard players operation #side xq_ctx = @e[tag=xq.actor,limit=1] xq_side
scoreboard players operation #side xq_ctx *= #minus xq_ctx
scoreboard players set @s xq_result 2
execute if score #side xq_ctx matches 1 run scoreboard players set @s xq_result 1
scoreboard players set @s xq_reason 7
function xiangqi:game/finish
''')
    put('game/offer_draw', [
        'function xiangqi:game/actor_guard', 'execute unless score #actor_ok xq_ctx matches 1 run return 0',
        'execute unless score @s xq_state matches 1 run return 0',
        'execute unless score @s xq_bot matches 0 run return run function xiangqi:game/bot_draw',
        'scoreboard players operation @s xq_draw = @e[tag=xq.actor,limit=1] xq_side',
        'scoreboard players set @s xq_undo 0',
        'scoreboard players add @s xq_epoch 1', say('一方提出和棋，可按 Q 在对局面板中接受或拒绝。'), 'function xiangqi:ui/refresh'])
    put('game/bot_draw', [say('人机同意和棋。'), 'scoreboard players set @s xq_result 3',
        'scoreboard players set @s xq_reason 8', 'function xiangqi:game/finish'])
    put('game/accept_draw', '''
function xiangqi:game/actor_guard
execute unless score #actor_ok xq_ctx matches 1 run return 0
execute unless score @s xq_state matches 1 run return 0
execute if score @s xq_draw matches 0 run return 0
execute if score @e[tag=xq.actor,limit=1] xq_side = @s xq_draw run return 0
scoreboard players set @s xq_result 3
scoreboard players set @s xq_reason 8
function xiangqi:game/finish
''')
    put('game/decline_draw', [
        'function xiangqi:game/actor_guard', 'execute unless score #actor_ok xq_ctx matches 1 run return 0',
        'execute unless score @s xq_state matches 1 run return 0', 'execute if score @s xq_draw matches 0 run return 0',
        'execute if score @e[tag=xq.actor,limit=1] xq_side = @s xq_draw run return 0',
        'scoreboard players set @s xq_draw 0', 'scoreboard players add @s xq_epoch 1', say('和棋提议已被拒绝。'), 'function xiangqi:ui/refresh'])

    # 保存最后一着之前的完整局面。非法尝试只写pending，不覆盖已可悔的上一着。
    undo_scores = ['turn','half','full','rtime','btime','rcapt','bcapt','check','repetition']
    snapshot = ['function xiangqi:system/context',
        'data modify entity @s data.xiangqi.pending_undo set value {board:[]}',
        'data modify entity @s data.xiangqi.pending_undo.history set from entity @s data.xiangqi.history',
        'data modify entity @s data.xiangqi.pending_undo.captured set from entity @s data.xiangqi.captured']
    snapshot += [f'execute store result entity @s data.xiangqi.pending_undo.{field} int 1 run scoreboard players get @s xq_{field}' for field in undo_scores]
    for sq in range(90):
        snapshot += ['data modify entity @s data.xiangqi.pending_undo.board append value 0',
            f'execute store result entity @s data.xiangqi.pending_undo.board[{sq}] int 1 run scoreboard players get @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={sq}}},limit=1] xq_piece']
    put('game/snapshot', snapshot)
    put('game/offer_undo', [
        'function xiangqi:game/actor_guard', 'execute unless score #actor_ok xq_ctx matches 1 run return 0',
        'execute unless score @s xq_state matches 1 run return 0',
        'execute unless score @s xq_bot matches 0 run return run function xiangqi:game/bot_undo',
        'execute unless data entity @s data.xiangqi.undo run ' + say('目前没有可撤回的走子。', '@a[tag=xq.actor]', 'red'),
        'execute unless data entity @s data.xiangqi.undo run return 0',
        'scoreboard players operation @s xq_undo = @e[tag=xq.actor,limit=1] xq_side',
        'scoreboard players set @s xq_draw 0', 'scoreboard players add @s xq_epoch 1',
        say('对手申请悔棋，手持对局菜单按 Q 回应。'),
        'function xiangqi:ui/refresh'])
    put('game/bot_undo', [
        'execute unless data entity @s data.xiangqi.ai_undo run ' + say('你还没有可撤回的走子。', '@a[tag=xq.actor]', 'red'),
        'execute unless data entity @s data.xiangqi.ai_undo run return 0',
        'data modify entity @s data.xiangqi.undo set from entity @s data.xiangqi.ai_undo',
        'function xiangqi:game/restore_undo'])
    put('game/decline_undo', [
        'function xiangqi:game/actor_guard','execute unless score #actor_ok xq_ctx matches 1 run return 0',
        'execute unless score @s xq_state matches 1 run return 0', 'execute if score @s xq_undo matches 0 run return 0',
        'execute if score @e[tag=xq.actor,limit=1] xq_side = @s xq_undo run return 0',
        'scoreboard players set @s xq_undo 0', 'scoreboard players add @s xq_epoch 1',
        say('悔棋申请已被拒绝。'), 'function xiangqi:ui/refresh'])
    restore_guard = ['function xiangqi:game/actor_guard','execute unless score #actor_ok xq_ctx matches 1 run return 0',
        'execute unless score @s xq_state matches 1 run return 0', 'execute if score @s xq_undo matches 0 run return 0',
        'execute if score @e[tag=xq.actor,limit=1] xq_side = @s xq_undo run return 0',
        'execute unless data entity @s data.xiangqi.undo run return 0']
    put('game/accept_undo', restore_guard + ['function xiangqi:game/restore_undo'])
    restore = ['function xiangqi:ai/reset']
    restore += [f'execute store result score @s xq_{field} run data get entity @s data.xiangqi.undo.{field}' for field in undo_scores]
    restore += ['data modify entity @s data.xiangqi.history set from entity @s data.xiangqi.undo.history',
        'data modify entity @s data.xiangqi.captured set from entity @s data.xiangqi.undo.captured',
        'data modify storage xiangqi:undo saved set from entity @s data.xiangqi.undo']
    for sq in range(90):
        restore += [f'execute store result score #restore xq_ctx run data get storage xiangqi:undo saved.board[{sq}]',
                    f'scoreboard players operation @e[type=minecraft:marker,tag=xq.board,scores={{xq_sq={sq}}},limit=1] xq_piece = #restore xq_ctx']
    restore += ['data remove entity @s data.xiangqi.undo', 'data remove entity @s data.xiangqi.pending_undo',
        'data remove entity @s data.xiangqi.ai_undo',
        'data remove entity @s data.xiangqi.last', 'data remove storage xiangqi:undo saved',
        'scoreboard players set @s xq_undo 0','scoreboard players set @s xq_draw 0',
        'scoreboard players set @s xq_sel -1','scoreboard players set @s xq_result 0','scoreboard players set @s xq_reason 0',
        'scoreboard players add @s xq_epoch 1', 'function xiangqi:visual/refresh', 'function xiangqi:clock/update',
        'function xiangqi:ui/refresh',
        'execute if score @s xq_bot matches 0 run ' + say('对手同意悔棋，已撤回最后一步，并恢复该步之前的局面与时钟。'),
        'execute unless score @s xq_bot matches 0 run ' + say('人机同意悔棋，已恢复到你上次走子之前的局面与时钟。')]
    put('game/restore_undo', restore)
    reasons = {1:'将死',2:'困毙（无合法着法）',3:'双方均无进攻子力',4:'重复局面或单方长将',5:'连续120着（双方合计）未吃子',6:'超时',7:'认输',8:'双方同意和棋',11:'棋盘数据不完整或异常'}
    finish = ['function xiangqi:system/context',
              'function xiangqi:ai/reset',
              'execute unless score @s xq_state matches 4 run function xiangqi:sound/end',
              'scoreboard players set @s xq_state 4', 'scoreboard players set @s xq_timer 100',
              'scoreboard players set @s xq_sel -1', 'scoreboard players set @s xq_draw 0', 'scoreboard players set @s xq_undo 0', 'scoreboard players add @s xq_epoch 1',
              'function xiangqi:visual/finish_move', 'function xiangqi:visual/select',
              'data modify entity @s data.xiangqi.result set value "和棋"',
              'execute if score @s xq_result matches 1 run data modify entity @s data.xiangqi.result set value "红方获胜"',
              'execute if score @s xq_result matches 2 run data modify entity @s data.xiangqi.result set value "黑方获胜"',
              'data modify storage xiangqi:runtime result.title set from entity @s data.xiangqi.result',
              'data modify storage xiangqi:runtime result.reason set value "对局结束"']
    finish += [f'execute if score @s xq_reason matches {n} run data modify storage xiangqi:runtime result.reason set value "{reason}"' for n,reason in reasons.items()]
    finish += ['function xiangqi:game/result_text with storage xiangqi:runtime result', 'function xiangqi:clock/update', 'function xiangqi:ui/refresh', 'function xiangqi:log {text:"对局结束，五秒后返回大厅"}']
    put('game/finish', finish)
    put('game/result_text', '$tellraw @a[tag=xq.audience] [{text:"[中国象棋] $(title)",color:"gold",bold:true},{text:"：$(reason)。五秒后返回大厅。",color:"yellow"}]')
    put('game/result_tick', '''
scoreboard players remove @s xq_timer 1
execute if score @s xq_timer matches ..0 run function xiangqi:game/cleanup
''')
    put('player/clear_state', '''
function xiangqi:input/clear
scoreboard players reset @s xq_table
scoreboard players reset @s xq_side
scoreboard players reset @s xq_seat
scoreboard players reset @s xq_weight
tag @s remove xq.player
tag @s remove xq.audience
''')
    put('game/cleanup', '''
# 返回大厅并保留终局棋面，清除计时和输入；再次开局或切换游戏才重摆。
scoreboard players set @s xq_state 0
scoreboard players set @s xq_sel -1
scoreboard players set @s xq_draw 0
scoreboard players set @s xq_undo 0
data modify entity @s data.xiangqi.review set value 1b
function xiangqi:ai/reset
function xiangqi:system/context
function xiangqi:visual/finish_move
function xiangqi:visual/select
execute as @e[type=minecraft:text_display,tag=xq.clock] if score @s ct_id = #table xq_ctx run kill @s
execute as @a[tag=xq.player] if score @s xq_table = #table xq_ctx run function xiangqi:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}] run function xiangqi:player/kill_drop
function cardtable:game/return_lobby
''')
    put('player/kill_drop', '''
execute store result score #drop_table xq_ctx run data get entity @s Item.components."minecraft:custom_data".xiangqi.table
execute if score #drop_table xq_ctx = #table xq_ctx run kill @s
''')
    put('game/remove', '''
# 切换游戏/删除牌桌专用：不重新生成预览，不更改即将选中的游戏。
function xiangqi:settings/invalidate_table
function xiangqi:ai/reset
data remove entity @s data.xiangqi.review
function xiangqi:system/context
execute as @a[tag=xq.player] if score @s xq_table = #table xq_ctx run function xiangqi:player/clear_state
function xiangqi:visual/clear
kill @e[type=minecraft:marker,tag=xq.board]
tag @s remove xq.controller
tag @s remove xq.current
scoreboard players set @s xq_state 0
''')
    put('game/abort', ['execute unless entity @s[tag=xq.controller] run return fail', 'function xiangqi:system/context', say('本场已中止，牌桌返回大厅。'), 'function xiangqi:game/cleanup'])
    put('game/end_vote', ['execute unless entity @s[tag=xq.controller] run return fail', 'function xiangqi:system/context', say('结束投票通过，本场提前结束。'), 'function xiangqi:game/cleanup'])
    put('admin/abort', '''
# 可直接 /function 调用；只处理同维度八格内最近的一场中国象棋。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[中国象棋] 同维度 8 格内没有正在运行的中国象棋牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=xq.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function xiangqi:game/abort
''')
    put('log', '$tellraw @a[tag=ct.debug] [{text:"[中国象棋 Debug] $(text)",color:"gray"}]')
    print('Generated xiangqi lifecycle / clock / admin functions.')


if __name__ == '__main__':
    main()
