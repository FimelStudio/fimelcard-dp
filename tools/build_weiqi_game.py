"""生成围棋 20 的生命周期、双人座位、计时与复盘。

规则引擎、对话框、展示分别由独立的 build_weiqi_* 脚本维护。
围棋独占 go_ / go.*，绝不复用问非所答的 wq_ 状态。
"""
from pathlib import Path
import importlib.util
import json

ROOT = Path(__file__).resolve().parents[1] / 'data/weiqi/function'
OBJECTIVES = {name: 'dummy' for name in '''go_ctx go_state go_sq go_file go_rank go_piece go_dead
go_turn go_moves go_passes go_bcap go_wcap go_epoch go_result go_reason go_sel go_timer
go_black go_white go_table go_side go_seat go_weight go_btime go_wtime go_board go_orient
go_time go_pulse go_seen go_first go_undo go_bot go_level go_size go_mark go_coords go_confirm
go_komi go_estimate go_bconfirm go_wconfirm go_review go_autoplay go_reviewtable go_revelig
go_view go_aistate go_aiwait go_aiepoch go_aibest go_aiscore go_aiattempt go_aimoves
go_setnonce go_ui_load go_action go_settings go_coord go_coordnonce go_set_table'''.split()}
for _name in ('go_action', 'go_settings', 'go_coord'):
    OBJECTIVES[_name] = 'trigger'
OBJECTIVES['go_drop'] = 'minecraft.dropped:minecraft.paper'


def put(name, lines):
    p = ROOT / (name + '.mcfunction')
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(('\n'.join(lines) if isinstance(lines, list) else lines).strip() + '\n', encoding='utf-8')


def say(text, target='@a[tag=go.audience]', color='yellow'):
    return 'tellraw ' + target + ' ' + json.dumps({'text': '[围棋] ' + text, 'color': color}, ensure_ascii=False)


def main():
    objectives = dict(OBJECTIVES)
    # 聚合分模块公开的目标，确保第一次 load 就拥有对话框/引擎需要的目标。
    for module in ('engine', 'ui', 'input', 'settings', 'ai'):
        p = Path(__file__).with_name(f'build_weiqi_{module}.py')
        if not p.exists():
            continue
        spec = importlib.util.spec_from_file_location(f'_weiqi_{module}_objectives', p)
        loaded = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(loaded)
        extra = getattr(loaded, 'OBJECTIVES', {})
        objectives.update(extra if isinstance(extra, dict) else {n: 'dummy' for n in extra})
    put('system/install', [f'scoreboard objectives add {o} {criterion}' for o, criterion in sorted(objectives.items()) if o != 'go_ctx'] + ['scoreboard players set #version go_ctx 2'])
    put('load', '''
scoreboard objectives add go_ctx dummy
execute unless score #version go_ctx matches 2.. run function weiqi:system/install
function weiqi:visual/load
scoreboard players set #minus go_ctx -1
scoreboard players set #two go_ctx 2
scoreboard players set #nineteen go_ctx 19
scoreboard players set #twenty go_ctx 20
scoreboard players set #sixty go_ctx 60
scoreboard players set #minute go_ctx 1200
execute unless score #setting_serial go_ctx matches 9999..99999 run scoreboard players set #setting_serial go_ctx 9999
scoreboard players add #ui_load go_ctx 1
scoreboard players reset * go_action
scoreboard players reset * go_settings
scoreboard players reset * go_coord
scoreboard players reset * go_setnonce
scoreboard players reset * go_coordnonce
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20}] at @s run function weiqi:system/reload
''')
    put('system/context', '''
# 每次入口重新绑定本桌；临时 actor 由输入层独立管理。
scoreboard players operation #table go_ctx = @s ct_id
tag @e[tag=go.current] remove go.current
tag @e[tag=go.board] remove go.board
tag @a[tag=go.audience] remove go.audience
tag @s add go.current
execute as @e[type=minecraft:marker,tag=go.square] if score @s ct_id = #table go_ctx run tag @s add go.board
execute as @a[tag=go.player,tag=ct.player] if score @s go_table = #table go_ctx if score @s ct_id = #table go_ctx run tag @s add go.audience
''')
    init = ['tag @s add go.controller']
    for field, guard, default in [('board', '0..1', 0), ('orient', '0..1', 0), ('time', '0..30', 10), ('first', '0..1', 1), ('level', '1..3', 2), ('mark', '0..1', 1), ('coords', '0..1', 1), ('confirm', '0..1', 0), ('estimate', '0..1', 1), ('komi', '-40..40', 15), ('epoch', '1..', 1)]:
        init.append(f'execute unless score @s go_{field} matches {guard} run scoreboard players set @s go_{field} {default}')
    init += ['execute unless score @s go_size matches 13 unless score @s go_size matches 15 unless score @s go_size matches 19 run scoreboard players set @s go_size 19']
    put('game/config', init)
    put('game/init_table', ['function weiqi:game/config', 'execute if score @s ct_state matches 0 run function weiqi:game/preview'])
    put('system/create_board', ['function weiqi:system/context', 'kill @e[type=minecraft:marker,tag=go.board]', 'scoreboard players operation #size go_ctx = @s go_size'] + [f'execute if score #size go_ctx matches {max(sq % 19, sq // 19)+1}.. summon minecraft:marker run function weiqi:system/square {{sq:{sq},file:{sq%19},rank:{sq//19}}}' for sq in range(361)] + ['function weiqi:system/context'])
    put('system/square', '''
tag @s add go.square
scoreboard players operation @s ct_id = #table go_ctx
$scoreboard players set @s go_sq $(sq)
$scoreboard players set @s go_file $(file)
$scoreboard players set @s go_rank $(rank)
scoreboard players set @s go_piece 0
scoreboard players set @s go_dead 0
''')
    put('game/preview', '''
execute unless score @s ct_game matches 20 run return 0
execute unless score @s ct_state matches 0 run return 0
execute if data entity @s data.weiqi{review:1b} run return run function weiqi:game/preserve_review
scoreboard players set @s go_state 0
scoreboard players set @s go_sel -1
scoreboard players set @s go_timer 0
scoreboard players set @s go_pulse 0
scoreboard players set @s go_bot 0
scoreboard players set @s go_undo 0
scoreboard players set @s go_autoplay 0
scoreboard players add @s go_epoch 1
function weiqi:ai/reset
function weiqi:visual/clear
function weiqi:system/create_board
function weiqi:engine/init_board
function weiqi:visual/setup
''')
    put('game/preserve_review', '''
function weiqi:system/context
# 保留终局或当前复盘帧；外观设置只重绘，不重开局。
execute unless score @s go_state matches 5 run scoreboard players set @s go_state 0
scoreboard players add @s go_epoch 1
function weiqi:visual/refresh
''')
    put('system/reload', '''
tag @s add go.controller
execute if score @s ct_state matches 0 run function weiqi:game/init_table
execute if score @s ct_state matches 0 run return run function weiqi:game/restore_review_tools
function weiqi:system/context
scoreboard players add @s go_epoch 1
function weiqi:ai/reset
function weiqi:game/reseat
# 动画被重载截断时直接完成，不重走一次、也不重置时钟。
execute if score @s go_state matches 2 run scoreboard players set @s go_state 1
function weiqi:visual/refresh
execute if score @s go_state matches 3 run function weiqi:engine/score
execute if score @s go_state matches 3 run function weiqi:visual/estimate
execute if score @s go_state matches 1 if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:engine/estimate
execute if score @s go_state matches 1 if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:visual/estimate
function weiqi:clock/create
execute as @a[tag=go.audience] run function weiqi:input/give
function weiqi:ui/refresh
''')
    put('game/start', [
        'function weiqi:game/config',
        'execute unless score @s ct_joined matches 1..2 run ' + say('支持一至两名玩家，单人由基础人机陪练。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute unless score @s ct_joined matches 1..2 run return fail',
        'function weiqi:system/context', 'scoreboard players set #online go_ctx 0', 'scoreboard players set #blocked go_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx run scoreboard players add #online go_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}] run scoreboard players set #blocked go_ctx 1',
        'execute unless score #online go_ctx = @s ct_joined run return fail',
        'execute if score #blocked go_ctx matches 1 run ' + say('请先清空快捷栏最后一格。', '@a[tag=ct.start_actor,limit=1]', 'red'),
        'execute if score #blocked go_ctx matches 1 run return fail',
        'function weiqi:system/side_seats',
        'scoreboard players set #black_ready go_ctx 0', 'scoreboard players set #white_ready go_ctx 0',
        'execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx run function weiqi:player/seat_side',
        'execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx if score @s go_weight matches 1 run scoreboard players add #black_ready go_ctx 1',
        'execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx if score @s go_weight matches -1 run scoreboard players add #white_ready go_ctx 1',
        'function weiqi:game/check_sides',
        'execute if score @s go_first matches 1 if score #side_ok go_ctx matches 0 run function weiqi:game/seat_hint',
        'execute if score @s go_first matches 1 if score #side_ok go_ctx matches 0 run return fail',
        # 只有校验通过才清旧复盘、创建新棋局。
        'execute as @a[tag=go.player] if score @s go_table = #table go_ctx run function weiqi:player/clear_state',
        'execute as @a[tag=ct.player] if score @s ct_id = #table go_ctx run function weiqi:player/init',
        # clear_state 清除了上一局全部专属字段，入座权重须在身份清理后重算。
        'function weiqi:system/context', 'function weiqi:system/side_seats',
        'execute as @a[tag=go.audience] run function weiqi:player/seat_side',
        'function weiqi:game/assign_sides', 'function weiqi:game/reseat',
        'execute unless score #seats_ok go_ctx matches 1 run function weiqi:game/start_failed',
        'execute unless score #seats_ok go_ctx matches 1 run return fail',
        'function weiqi:settings/invalidate_table',
        'data remove entity @s data.weiqi.review', 'data remove entity @s data.weiqi.finalresult', 'data remove entity @s data.weiqi.result', 'function weiqi:system/create_board',
        'scoreboard players operation @s go_btime = @s go_time', 'scoreboard players operation @s go_btime *= #minute go_ctx',
        'scoreboard players operation @s go_wtime = @s go_btime', 'function weiqi:engine/init_board',
        'scoreboard players set @s go_state 1', 'scoreboard players set @s go_sel -1', 'scoreboard players set @s go_timer 0',
        'scoreboard players set @s go_result 0', 'scoreboard players set @s go_reason 0', 'scoreboard players set @s go_pulse 0',
        'scoreboard players set @s go_undo 0', 'scoreboard players set @s go_bconfirm 0', 'scoreboard players set @s go_wconfirm 0',
        'scoreboard players set @s go_autoplay 0', 'scoreboard players add @s go_epoch 1', 'function weiqi:ai/reset',
        'function weiqi:game/capture_names', 'function weiqi:visual/setup',
        'execute as @a[tag=go.audience] run function weiqi:input/give',
        'scoreboard players set @s ct_start 1', 'function weiqi:clock/create', 'function weiqi:ui/refresh', 'function weiqi:sound/start',
        say('黑方先行。右键交点落子，最后一格按 Q 打开对局菜单。双方连续停一手后确认死活并计分。'),
        'function weiqi:game/announce_sides', 'function weiqi:log {text:"围棋开始"}',
    ])
    put('game/start_failed', ['function weiqi:system/context', say('座椅骑乘失败，请重新入座后开始。', color='red'), 'execute as @a[tag=go.audience] run function weiqi:player/clear_state'])
    put('player/init', '''
tag @s add go.player
scoreboard players operation @s go_table = @s ct_id
scoreboard players operation @s go_seat = @s ct_seat
scoreboard players set @s go_side -1
scoreboard players set @s go_seen -1
scoreboard players set @s go_view 0
scoreboard players set @s go_revelig 0
''')
    put('game/check_sides', '''
scoreboard players set #side_ok go_ctx 0
execute if score @s ct_joined matches 2 if score #black_ready go_ctx matches 1 if score #white_ready go_ctx matches 1 run scoreboard players set #side_ok go_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready go_ctx matches 1 run scoreboard players set #side_ok go_ctx 1
execute if score @s ct_joined matches 1 if score #white_ready go_ctx matches 1 run scoreboard players set #side_ok go_ctx 1
''')
    put('game/assign_sides', '''
scoreboard players set @s go_bot 0
execute if score @s ct_joined matches 1 run return run function weiqi:game/solo_sides
scoreboard players set @a[tag=go.audience] go_side -1
execute if score @s go_first matches 0 run scoreboard players set @a[tag=go.audience,sort=random,limit=1] go_side 1
execute if score @s go_first matches 1 as @a[tag=go.audience] if score @s go_weight matches 1 run scoreboard players set @s go_side 1
''')
    put('game/solo_sides', '''
scoreboard players set #human_side go_ctx 1
execute if score @s go_first matches 0 store result score #human_side go_ctx run random value 0..1
execute if score #human_side go_ctx matches 0 run scoreboard players set #human_side go_ctx -1
execute if score @s go_first matches 1 run scoreboard players operation #human_side go_ctx = @a[tag=go.audience,limit=1] go_weight
scoreboard players operation @a[tag=go.audience,limit=1] go_side = #human_side go_ctx
scoreboard players operation @s go_bot = #human_side go_ctx
scoreboard players operation @s go_bot *= #minus go_ctx
''')
    sides = {(4, 0): ((3, 3), (1, 1)), (4, 1): ((4, 4), (2, 2)), (8, 0): ((5, 6), (1, 2)), (8, 1): ((7, 8), (3, 4))}
    seats, weights, hints = [], ['scoreboard players set @s go_weight 0'], []
    for (cap, orient), (black, white) in sides.items():
        guard = f'execute if score #cap go_ctx matches {cap} if score #orient go_ctx matches {orient}'
        for name, bounds, side in [('black', black, 1), ('white', white, -1)]:
            seats += [f'{guard} run scoreboard players set #{name}_{field} go_ctx {value}' for field, value in [('seat', bounds[0]), ('last', bounds[1])]]
            bounds_text = str(bounds[0]) if bounds[0] == bounds[1] else f'{bounds[0]}..{bounds[1]}'
            weights.append(f'{guard} if score @s ct_seat matches {bounds_text} run scoreboard players set @s go_weight {side}')
        hint = lambda bounds: str(bounds[0]) if bounds[0] == bounds[1] else f'{bounds[0]}／{bounds[1]}'
        hints.append(guard + ' run ' + say(f'按座位分边：黑方 {hint(black)} 号、白方 {hint(white)} 号；双人请两侧各坐一人，或选择随机分边。', '@a[tag=ct.start_actor,limit=1]', 'red'))
    put('system/side_seats', ['scoreboard players operation #cap go_ctx = @s ct_capacity', 'scoreboard players operation #orient go_ctx = @s go_orient'] + seats)
    put('player/seat_side', weights)
    put('game/seat_hint', hints)
    put('player/place_side', '''
# 只冻结目标，不提前改通用座位。两人全部下座后才提交，避免同椅。
scoreboard players operation @s go_seat = @s ct_seat
execute if score @s go_side matches 1 if score @s go_seat < #black_seat go_ctx run scoreboard players operation @s go_seat = #black_seat go_ctx
execute if score @s go_side matches 1 if score @s go_seat > #black_last go_ctx run scoreboard players operation @s go_seat = #black_seat go_ctx
execute if score @s go_side matches -1 if score @s go_seat < #white_seat go_ctx run scoreboard players operation @s go_seat = #white_seat go_ctx
execute if score @s go_side matches -1 if score @s go_seat > #white_last go_ctx run scoreboard players operation @s go_seat = #white_seat go_ctx
''')
    put('game/reseat', '''
function weiqi:system/context
function weiqi:system/side_seats
scoreboard players set #black_ready go_ctx 0
scoreboard players set #white_ready go_ctx 0
execute as @a[tag=go.audience,scores={go_side=1}] run scoreboard players add #black_ready go_ctx 1
execute as @a[tag=go.audience,scores={go_side=-1}] run scoreboard players add #white_ready go_ctx 1
execute if score @s go_bot matches 1 run scoreboard players add #black_ready go_ctx 1
execute if score @s go_bot matches -1 run scoreboard players add #white_ready go_ctx 1
scoreboard players set #seats_ok go_ctx 0
execute unless score #black_ready go_ctx matches 1 run return 0
execute unless score #white_ready go_ctx matches 1 run return 0
execute as @a[tag=go.audience] run function weiqi:player/place_side
execute as @a[tag=go.audience] run ride @s dismount
execute as @a[tag=go.audience] run scoreboard players operation @s ct_seat = @s go_seat
scoreboard players operation @s go_black = #black_seat go_ctx
scoreboard players operation @s go_white = #white_seat go_ctx
execute unless score @s go_bot matches 1 run scoreboard players operation @s go_black = @a[tag=go.audience,scores={go_side=1},limit=1] go_seat
execute unless score @s go_bot matches -1 run scoreboard players operation @s go_white = @a[tag=go.audience,scores={go_side=-1},limit=1] go_seat
function cardtable:table/ensure_seats
scoreboard players set #seats_ok go_ctx 1
execute as @a[tag=go.audience,scores={go_side=1},limit=1] at @s run function weiqi:player/mount_side
execute as @a[tag=go.audience,scores={go_side=-1},limit=1] at @s run function weiqi:player/mount_side
return run scoreboard players get #seats_ok go_ctx
''')
    put('player/mount_side', '''
function cardtable:seat/mount
scoreboard players operation #mount_seat go_ctx = @s go_seat
scoreboard players set #mounted go_ctx 0
execute on vehicle if entity @s[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #table go_ctx if score @s ct_seat = #mount_seat go_ctx run scoreboard players set #mounted go_ctx 1
execute unless score #mounted go_ctx matches 1 run scoreboard players set #seats_ok go_ctx 0
''')
    put('game/capture_names', '''
data modify entity @s data.weiqi.black_name set value {text:"基础人机",color:"aqua"}
data modify entity @s data.weiqi.white_name set value {text:"基础人机",color:"aqua"}
execute as @a[tag=go.audience] run function weiqi:player/capture_name
''')
    put('player/capture_name', '''
function weiqi:name/capture
execute if score @s go_side matches 1 run data modify entity @e[tag=go.current,limit=1] data.weiqi.black_name set from storage weiqi:runtime name.value
execute if score @s go_side matches -1 run data modify entity @e[tag=go.current,limit=1] data.weiqi.white_name set from storage weiqi:runtime name.value
''')
    put('game/announce_sides', 'tellraw @a[tag=go.audience] [{text:"[围棋] 黑方：",color:"gold"},{nbt:"data.weiqi.black_name",entity:"@s",interpret:true},{text:"　白方：",color:"gray"},{nbt:"data.weiqi.white_name",entity:"@s",interpret:true}]')
    put('game/actor_guard', '''
function weiqi:system/context
scoreboard players set #actor_ok go_ctx 0
execute as @a[tag=go.actor,tag=go.audience,limit=1] if score @s go_table = #table go_ctx if score @s go_side matches -1..1 unless score @s go_side matches 0 run scoreboard players set #actor_ok go_ctx 1
''')
    actor = ['function weiqi:game/actor_guard', 'execute unless score #actor_ok go_ctx matches 1 run return 0']
    turn_guard = actor + ['execute unless score @s go_state matches 1 run return 0', 'execute unless score @a[tag=go.actor,limit=1] go_side = @s go_turn run return 0']
    put('game/click', turn_guard + [
        'execute if score @s go_confirm matches 1 unless score @s go_sel = #to go_ctx run return run function weiqi:game/confirm_target',
        'function weiqi:engine/try_move', 'execute unless score #legal go_ctx matches 1 run return run function weiqi:game/illegal',
        'function weiqi:game/after_move'])
    put('game/confirm_target', ['function weiqi:engine/check_move', 'execute unless score #legal go_ctx matches 1 run return run function weiqi:game/illegal', 'function weiqi:game/select'])
    put('game/select', ['scoreboard players operation @s go_sel = #to go_ctx', 'function weiqi:visual/select'])
    put('game/illegal', ['scoreboard players set @s go_sel -1', 'function weiqi:visual/select', 'function weiqi:sound/illegal'] + [f'execute if score #error go_ctx matches {n} run ' + say(message, '@a[tag=go.actor]', 'red') for n, message in [(1,'请在棋盘交点落子。'),(2,'该交点已有棋子。'),(3,'不能自杀落子。'),(4,'该步会重复先前棋形，违反超级劫规则。')]])
    put('game/clear_requests', '''
scoreboard players set @s go_sel -1
scoreboard players set @s go_undo 0
scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
scoreboard players set @a[tag=go.audience] go_view 0
function weiqi:visual/clear_estimate
function weiqi:ai/reset
scoreboard players add @s go_epoch 1
''')
    put('game/after_move', '''
function weiqi:game/clear_requests
function weiqi:visual/place
function weiqi:visual/capture
execute store result score #placed_captured go_ctx run data get entity @s data.weiqi.last.captured
execute if score #placed_captured go_ctx matches 1.. run function weiqi:sound/capture
execute if score #placed_captured go_ctx matches 0 run function weiqi:sound/move
function weiqi:game/announce_move
scoreboard players set @s go_state 2
scoreboard players set @s go_timer 6
function weiqi:clock/update
function weiqi:ui/refresh
scoreboard players set #legal go_ctx 1
''')
    announce = ['execute store result score #log_sq go_ctx run data get entity @s data.weiqi.last.sq', 'execute store result score #log_side go_ctx run data get entity @s data.weiqi.last.side', 'data modify storage weiqi:runtime move.side set value "黑方"', 'execute if score #log_side go_ctx matches -1 run data modify storage weiqi:runtime move.side set value "白方"']
    for sq in range(361):
        letter = 'ABCDEFGHJKLMNOPQRST'[sq % 19]
        announce.append(f'execute if score #log_sq go_ctx matches {sq} run data modify storage weiqi:runtime move.coord set value "{letter}{sq//19+1}"')
    announce += ['execute store result storage weiqi:runtime move.n int 1 run scoreboard players get @s go_moves', 'function weiqi:game/announce_text with storage weiqi:runtime move']
    put('game/announce_move', announce)
    put('game/announce_text', '$tellraw @a[tag=go.audience] [{text:"[围棋] 第 $(n) 手 · $(side) $(coord)",color:"yellow"}]')
    put('game/pass', turn_guard + ['function weiqi:game/pass_internal'])
    put('game/pass_internal', '''
function weiqi:system/context
function weiqi:engine/pass
function weiqi:game/clear_requests
function weiqi:sound/pass
execute if score @s go_turn matches -1 run tellraw @a[tag=go.audience] {text:"[围棋] 黑方停一手。",color:"yellow"}
execute if score @s go_turn matches 1 run tellraw @a[tag=go.audience] {text:"[围棋] 白方停一手。",color:"yellow"}
execute if score @s go_passes matches 2.. run return run function weiqi:game/start_scoring
function weiqi:clock/update
function weiqi:ui/refresh
''')
    put('game/animate_tick', '''
function weiqi:visual/tick
scoreboard players remove @s go_timer 1
execute if score @s go_timer matches ..0 run function weiqi:game/animation_done
''')
    put('game/animation_done', '''
function weiqi:visual/finish_move
scoreboard players set @s go_state 1
function weiqi:clock/update
function weiqi:ui/refresh
''')
    put('game/start_scoring', [
        'scoreboard players set @s go_state 3', 'scoreboard players set @s go_bconfirm 0', 'scoreboard players set @s go_wconfirm 0',
        'execute if score @s go_bot matches 1 run scoreboard players set @s go_bconfirm 1', 'execute if score @s go_bot matches -1 run scoreboard players set @s go_wconfirm 1',
        'scoreboard players set @e[tag=go.board] go_dead 0', 'function weiqi:engine/score', 'scoreboard players add @s go_epoch 1',
        'function weiqi:visual/estimate', 'function weiqi:sound/score', 'function weiqi:clock/update', 'function weiqi:ui/refresh',
        say('计分已暂停棋钟。右键棋子整组标记／取消死子，双方确认后才结算；有争议可恢复对局。面积计分不额外累加提子。')])
    put('game/toggle_dead', actor + ['execute unless score @s go_state matches 3 run return 0', 'function weiqi:engine/toggle_dead', 'execute unless score #ok go_ctx matches 1 run return 0', 'function weiqi:game/reset_score_confirm', 'function weiqi:engine/score', 'function weiqi:visual/refresh', 'function weiqi:visual/estimate', 'function weiqi:ui/refresh'])
    put('game/reset_score_confirm', '''
scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
execute if score @s go_bot matches 1 run scoreboard players set @s go_bconfirm 1
execute if score @s go_bot matches -1 run scoreboard players set @s go_wconfirm 1
scoreboard players add @s go_epoch 1
''')
    put('game/confirm_score', actor + ['execute unless score @s go_state matches 3 run return 0', 'execute if score @a[tag=go.actor,limit=1] go_side matches 1 run scoreboard players set @s go_bconfirm 1', 'execute if score @a[tag=go.actor,limit=1] go_side matches -1 run scoreboard players set @s go_wconfirm 1', 'scoreboard players add @s go_epoch 1', 'execute if score @s go_bconfirm matches 1 if score @s go_wconfirm matches 1 run return run function weiqi:game/settle_score', 'function weiqi:ui/refresh'])
    put('game/settle_score', '''
function weiqi:engine/score
scoreboard players set @s go_result 3
execute if score @s go_bscore > @s go_wscore run scoreboard players set @s go_result 1
execute if score @s go_wscore > @s go_bscore run scoreboard players set @s go_result 2
scoreboard players set @s go_reason 1
function weiqi:game/finish
''')
    put('game/resume', actor + ['execute unless score @s go_state matches 3 run return 0', 'scoreboard players set @s go_state 1', 'scoreboard players set @s go_passes 0', 'scoreboard players set @e[tag=go.board] go_dead 0', 'function weiqi:game/clear_requests', 'function weiqi:visual/refresh', 'function weiqi:clock/update', 'function weiqi:ui/refresh', say('已恢复对局，死子标记与确认已清除，保留当前棋形、轮次和超级劫历史。')])
    put('game/estimate', actor + [
        'execute unless score @s go_state matches 1..3 run return 0', 'execute unless score @s go_estimate matches 1 run return 0',
        'scoreboard players add @a[tag=go.actor,limit=1] go_view 1', 'execute if score @a[tag=go.actor,limit=1] go_view matches 2.. run scoreboard players set @a[tag=go.actor,limit=1] go_view 0',
        'execute if score @s go_state matches 3 run return run function weiqi:game/scoring_overlay',
        'execute if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:engine/estimate',
        'execute if entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:visual/estimate',
        'execute unless entity @a[tag=go.audience,scores={go_view=1}] run function weiqi:visual/clear_estimate',
        say('占地为局部影响的保守估算，未判定死活，未定点不计；标记同步显示在本桌棋盘。', '@a[tag=go.actor]', 'gray'), 'function weiqi:ui/refresh'])
    put('game/scoring_overlay', ['function weiqi:engine/score', 'function weiqi:visual/estimate', 'function weiqi:ui/refresh'])
    put('game/request_undo', actor + [
        'execute unless score @s go_state matches 1 run return 0', 'execute unless score @s go_moves matches 1.. run return 0',
        'execute unless score @s go_bot matches 0 run return run function weiqi:game/bot_undo',
        'scoreboard players operation @s go_undo = @a[tag=go.actor,limit=1] go_side', 'scoreboard players add @s go_epoch 1', say('对手申请撤回最后一手，按 Q 接受或拒绝。'), 'function weiqi:ui/refresh'])
    put('game/accept_undo', actor + ['execute unless score @s go_state matches 1 run return 0', 'execute if score @s go_undo matches 0 run return 0', 'execute if score @a[tag=go.actor,limit=1] go_side = @s go_undo run return 0', 'function weiqi:game/restore_undo'])
    put('game/reject_undo', actor + ['execute unless score @s go_state matches 1 run return 0', 'execute if score @s go_undo matches 0 run return 0', 'execute if score @a[tag=go.actor,limit=1] go_side = @s go_undo run return 0', 'scoreboard players set @s go_undo 0', 'scoreboard players add @s go_epoch 1', say('悔棋申请已被拒绝。'), 'function weiqi:ui/refresh'])
    put('game/restore_undo', ['function weiqi:engine/undo', 'function weiqi:game/clear_requests', 'scoreboard players set @e[tag=go.board] go_dead 0', 'function weiqi:visual/undo', 'function weiqi:visual/refresh', 'function weiqi:clock/update', 'function weiqi:ui/refresh', say('已撤回最后一手，恢复对应棋形、时钟、提子与超级劫历史。')])
    put('game/bot_undo', '''
# 撤回到真人最后一手之前；若人机刚回复，则同时撤回两手。
execute if score @a[tag=go.actor,limit=1] go_side matches 1 unless data entity @s data.weiqi.history[{last:{side:1}}] run return 0
execute if score @a[tag=go.actor,limit=1] go_side matches -1 unless data entity @s data.weiqi.history[{last:{side:-1}}] run return 0
scoreboard players set #undo_twice go_ctx 0
execute if score @s go_turn = @a[tag=go.actor,limit=1] go_side if score @s go_moves matches 2.. run scoreboard players set #undo_twice go_ctx 1
function weiqi:engine/undo
execute if score #undo_twice go_ctx matches 1 run function weiqi:engine/undo
function weiqi:game/clear_requests
function weiqi:visual/refresh
function weiqi:clock/update
function weiqi:ui/refresh
''')
    put('game/resign', actor + ['execute unless score @s go_state matches 1..3 run return 0', 'scoreboard players set @s go_result 1', 'execute if score @a[tag=go.actor,limit=1] go_side matches 1 run scoreboard players set @s go_result 2', 'scoreboard players set @s go_reason 7', 'function weiqi:game/finish'])
    put('game/timeout', ['scoreboard players set @s go_result 1', 'execute if score @s go_turn matches 1 run scoreboard players set @s go_result 2', 'scoreboard players set @s go_reason 6', 'function weiqi:game/finish'])
    put('game/finish', '''
# 先锁定结算，防止超时/断线/重复确认重入。
execute unless score @s go_state matches 1..3 run return 0
execute unless score @s go_result matches 1..3 run return 0
scoreboard players set @s go_state 4
function weiqi:system/context
function weiqi:ai/reset
scoreboard players set @s go_timer 100
scoreboard players set @s go_sel -1
scoreboard players set @s go_undo 0
scoreboard players add @s go_epoch 1
execute store result entity @s data.weiqi.finalresult int 1 run scoreboard players get @s go_result
data modify entity @s data.weiqi.result set value "和棋"
execute if score @s go_result matches 1 run data modify entity @s data.weiqi.result set value "黑方获胜"
execute if score @s go_result matches 2 run data modify entity @s data.weiqi.result set value "白方获胜"
function weiqi:visual/finish_move
function weiqi:sound/end
function weiqi:game/result_text
execute if score @s go_result matches 1..2 run function weiqi:game/firework
function weiqi:clock/update
function weiqi:ui/refresh
function weiqi:log {text:"围棋结束，五秒后回大厅并保留终局"}
''')
    put('game/result_text', ['tellraw @a[tag=go.audience] [{text:"[围棋] ",color:"gold"},{nbt:"data.weiqi.result",entity:"@s",interpret:false,color:"gold",bold:true},{text:"。五秒后返回大厅，可通过最后一格菜单复盘。",color:"yellow"}]', 'execute if score @s go_reason matches 1 run function weiqi:game/result_score', 'execute if score @s go_reason matches 6 run ' + say('胜负原因：一方超时。'), 'execute if score @s go_reason matches 7 run ' + say('胜负原因：一方认输。')])
    put('game/result_score', ['function weiqi:ui/value_bscore', 'function weiqi:ui/value_wscore', 'function weiqi:ui/value_komi', 'function weiqi:ui/half {key:"bscore"}', 'function weiqi:ui/half {key:"wscore"}', 'function weiqi:ui/half {key:"komi"}', 'function weiqi:game/result_score_text with storage weiqi:ui'])
    put('game/result_score_text', '$tellraw @a[tag=go.audience] {text:"[围棋] 面积计分：黑 $(bscore_label) 目，白 $(wscore_label) 目（含贴目 $(komi_label) 目）。提子不另计分。",color:"gray"}')
    put('game/firework', '''
scoreboard players set #winner go_ctx 1
execute if score @s go_result matches 2 run scoreboard players set #winner go_ctx -1
execute as @a[tag=go.audience] if score @s go_side = #winner go_ctx at @s positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["go.firework","go.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=go.firework.new] ct_id = #table go_ctx
tag @e[type=minecraft:firework_rocket,tag=go.firework.new] remove go.firework.new
''')
    put('game/result_tick', ['scoreboard players remove @s go_timer 1', 'execute if score @s go_timer matches ..0 run function weiqi:game/cleanup'])
    put('game/cleanup', '''
function weiqi:system/context
scoreboard players set @s go_state 0
scoreboard players set @s go_sel -1
scoreboard players set @s go_undo 0
scoreboard players set @s go_autoplay 0
data modify entity @s data.weiqi.review set value 1b
execute store result score @s go_review run data get entity @s data.weiqi.history
scoreboard players remove @s go_review 1
function weiqi:ai/reset
function weiqi:visual/finish_move
execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run kill @s
execute as @a[tag=go.audience] run scoreboard players set @s go_revelig 1
execute as @a[tag=go.audience] run scoreboard players operation @s go_reviewtable = @s ct_id
execute as @a[tag=go.audience] run function weiqi:input/give
execute as @e[type=minecraft:firework_rocket,tag=go.firework] if score @s ct_id = #table go_ctx run kill @s
function cardtable:game/return_lobby
''')
    put('game/review_guard', ['scoreboard players set #review_ok go_ctx 0'] + actor + ['execute unless score @s ct_state matches 0 run return 0', 'execute unless data entity @s data.weiqi{review:1b} run return 0', 'execute unless score @a[tag=go.actor,limit=1] go_revelig matches 1 run return 0', 'execute unless score @a[tag=go.actor,limit=1] go_reviewtable = #table go_ctx run return 0', 'scoreboard players set #review_ok go_ctx 1'])
    review_guard = ['function weiqi:game/review_guard', 'execute unless score #review_ok go_ctx matches 1 run return 0']
    put('game/review_open', review_guard + ['scoreboard players set @s go_state 5', 'scoreboard players set @s go_autoplay 0', 'scoreboard players add @s go_epoch 1', 'function weiqi:game/review_render'])
    put('game/review_start', 'function weiqi:game/review_open')
    put('game/review_render', '''
scoreboard players operation #frame go_ctx = @s go_review
function weiqi:engine/review
execute if data entity @s data.weiqi.finalresult store result score @s go_result run data get entity @s data.weiqi.finalresult
function weiqi:visual/review
function weiqi:ui/refresh
''')
    put('game/review_first', review_guard + ['scoreboard players set @s go_state 5', 'scoreboard players set @s go_autoplay 0', 'scoreboard players set @s go_review 0', 'scoreboard players add @s go_epoch 1', 'function weiqi:game/review_render'])
    put('game/review_last', review_guard + ['scoreboard players set @s go_state 5', 'scoreboard players set @s go_autoplay 0', 'execute store result score @s go_review run data get entity @s data.weiqi.history', 'scoreboard players remove @s go_review 1', 'scoreboard players add @s go_epoch 1', 'function weiqi:game/review_render'])
    put('game/review_prev', review_guard + ['scoreboard players set @s go_state 5', 'scoreboard players set @s go_autoplay 0', 'execute if score @s go_review matches 1.. run scoreboard players remove @s go_review 1', 'scoreboard players add @s go_epoch 1', 'function weiqi:game/review_render'])
    put('game/review_next', review_guard + ['scoreboard players set @s go_autoplay 0', 'function weiqi:game/review_advance'])
    put('game/review_advance', '''
scoreboard players operation #review_auto go_ctx = @s go_autoplay
scoreboard players set @s go_state 5
execute store result score #frames go_ctx run data get entity @s data.weiqi.history
scoreboard players remove #frames go_ctx 1
execute if score @s go_review < #frames go_ctx run scoreboard players add @s go_review 1
execute if score @s go_review >= #frames go_ctx run scoreboard players set @s go_autoplay 0
# 自动复盘只是更新只读帧，不使已打开的暂停按钮每 0.75 秒失效。
execute unless score #review_auto go_ctx matches 1 run scoreboard players add @s go_epoch 1
function weiqi:game/review_render
''')
    put('game/review_play', review_guard + ['scoreboard players set @s go_state 5', 'scoreboard players add @s go_autoplay 1', 'execute if score @s go_autoplay matches 2.. run scoreboard players set @s go_autoplay 0', 'scoreboard players set @s go_timer 0', 'scoreboard players add @s go_epoch 1', 'function weiqi:ui/refresh'])
    put('game/review_close', review_guard + ['execute store result score @s go_review run data get entity @s data.weiqi.history', 'scoreboard players remove @s go_review 1', 'scoreboard players set @s go_state 0', 'scoreboard players set @s go_autoplay 0', 'scoreboard players add @s go_epoch 1', 'function weiqi:game/review_render'])
    put('game/review_end', 'function weiqi:game/review_close')
    put('game/restore_review_tools', '''
execute unless data entity @s data.weiqi{review:1b} run return 0
function weiqi:system/context
execute as @a[tag=go.audience,scores={go_revelig=1}] if score @s go_reviewtable = #table go_ctx run function weiqi:input/give
''')
    put('player/clear_state', ['function weiqi:input/clear'] + [f'scoreboard players reset @s go_{f}' for f in ('table','side','seat','weight','reviewtable','revelig','view')] + ['tag @s remove go.player', 'tag @s remove go.audience'])
    put('game/remove', '''
function weiqi:settings/invalidate_table
function weiqi:system/context
function weiqi:ai/reset
execute as @a[tag=go.player] if score @s go_table = #table go_ctx run function weiqi:player/clear_state
function weiqi:visual/clear
kill @e[type=minecraft:marker,tag=go.board]
execute as @e[type=minecraft:firework_rocket,tag=go.firework] if score @s ct_id = #table go_ctx run kill @s
data remove entity @s data.weiqi
tag @s remove go.controller
tag @s remove go.current
scoreboard players set @s go_state 0
''')
    put('game/early_record', ['execute unless score @s go_state matches 1..3 run return 0', 'scoreboard players set @s go_result 0', 'data modify entity @s data.weiqi.finalresult set value 0', 'data modify entity @s data.weiqi.result set value "本场提前结束"'])
    put('game/abort', ['execute unless entity @s[tag=go.controller] run return fail', 'execute unless score @s ct_state matches 1 run return fail', 'function weiqi:system/context', 'function weiqi:game/early_record', say('本场已中止，牌桌返回大厅，保留棋面供复盘。'), 'function weiqi:game/cleanup'])
    put('game/end_vote', ['execute unless entity @s[tag=go.controller] run return fail', 'execute unless score @s ct_state matches 1 run return fail', 'function weiqi:system/context', 'function weiqi:game/early_record', say('结束投票通过，本场提前结束。'), 'function weiqi:game/cleanup'])
    put('game/player_left', '''
execute unless score @s ct_state matches 1 run return 0
function weiqi:system/context
scoreboard players set #online go_ctx 0
execute as @a[tag=go.audience] run scoreboard players add #online go_ctx 1
scoreboard players set #expected go_ctx 2
execute unless score @s go_bot matches 0 run scoreboard players set #expected go_ctx 1
execute unless score #online go_ctx = #expected go_ctx run function weiqi:game/abort
''')
    put('tick', '''
function weiqi:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20},tag=!go.controller] at @s run function weiqi:game/init_table
execute as @e[type=minecraft:marker,tag=go.controller,scores={ct_game=20}] at @s run function weiqi:system/tick
''')
    put('system/tick', '''
scoreboard players add @s go_pulse 1
execute if score @s go_state matches 1 run function weiqi:clock/tick
execute if score @s go_state matches 2 run function weiqi:game/animate_tick
execute if score @s go_state matches 4 run function weiqi:game/result_tick
execute if score @s go_state matches 1 run function weiqi:ai/tick
execute if score @s go_state matches 5 if score @s go_autoplay matches 1 run function weiqi:game/review_tick
execute if score @s go_pulse matches 20.. run function weiqi:system/heartbeat
''')
    put('game/review_tick', ['scoreboard players add @s go_timer 1', 'execute if score @s go_timer matches 15.. run scoreboard players set @s go_timer 0', 'execute if score @s go_timer matches 0 run function weiqi:game/review_advance'])
    put('system/heartbeat', '''
scoreboard players set @s go_pulse 0
function weiqi:system/context
execute if score @s ct_state matches 1 run function weiqi:game/player_left
execute if score @s ct_state matches 1 run function weiqi:clock/update
# 大厅离桌后的复盘物品不可继续操作；常规离座路径也会清理。
execute as @a[tag=go.player] unless entity @s[tag=ct.player] run function weiqi:player/clear_state
''')
    put('clock/create', ['function weiqi:system/context', 'execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run kill @s', 'execute positioned ~ ~3.0 ~ summon minecraft:text_display run function weiqi:clock/entity', 'function weiqi:clock/update'])
    put('clock/entity', '''
tag @s add go.clock
tag @s add go.visual
scoreboard players operation @s ct_id = #table go_ctx
data merge entity @s {billboard:"vertical",alignment:"center",line_width:320,background:0,shadow:1b,see_through:0b,view_range:0.5f,text:{text:"围棋",color:"gold",bold:true},brightness:{block:15,sky:15}}
''')
    put('clock/tick', '''
execute unless score @s go_state matches 1 run return 0
execute if score @s go_time matches 0 run return 0
execute if score @s go_turn matches 1 run scoreboard players remove @s go_btime 1
execute if score @s go_turn matches -1 run scoreboard players remove @s go_wtime 1
execute if score @s go_turn matches 1 if score @s go_btime matches ..0 run function weiqi:game/timeout
execute if score @s go_turn matches -1 if score @s go_wtime matches ..0 run function weiqi:game/timeout
''')
    clock = ['function weiqi:system/context', 'data modify storage weiqi:runtime clock.status set value "黑方落子"', 'execute if score @s go_turn matches -1 run data modify storage weiqi:runtime clock.status set value "白方落子"', 'execute if score @s go_state matches 2 run data modify storage weiqi:runtime clock.status set value "落子中"', 'execute if score @s go_state matches 3 run data modify storage weiqi:runtime clock.status set value "确认死活／计分"', 'execute if score @s go_state matches 4 run data modify storage weiqi:runtime clock.status set from entity @s data.weiqi.result', 'execute unless score @s go_bot matches 0 if score @s go_turn = @s go_bot if score @s go_state matches 1 run data modify storage weiqi:runtime clock.status set value "基础人机思考中"']
    for field in ('b','w'):
        clock += [f'scoreboard players operation #seconds go_ctx = @s go_{field}time', 'scoreboard players add #seconds go_ctx 19', 'scoreboard players operation #seconds go_ctx /= #twenty go_ctx', 'scoreboard players operation #minutes go_ctx = #seconds go_ctx', 'scoreboard players operation #minutes go_ctx /= #sixty go_ctx', 'scoreboard players operation #seconds go_ctx %= #sixty go_ctx', f'execute store result storage weiqi:runtime clock.{field}m int 1 run scoreboard players get #minutes go_ctx']
        clock += [f'execute if score #seconds go_ctx matches {s} run data modify storage weiqi:runtime clock.{field}s set value "{s:02d}"' for s in range(60)]
    clock += ['execute if score @s go_time matches 0 run return run function weiqi:clock/unlimited with storage weiqi:runtime clock', 'function weiqi:clock/timed with storage weiqi:runtime clock']
    put('clock/update', clock)
    put('clock/timed', '$execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run data modify entity @s text set value [{text:"围棋 · $(status)\\n",color:"gold"},{text:"黑 $(bm):$(bs)",color:"white"},{text:"　│　白 $(wm):$(ws)",color:"gray"}]')
    put('clock/unlimited', '$execute as @e[type=minecraft:text_display,tag=go.clock] if score @s ct_id = #table go_ctx run data modify entity @s text set value [{text:"围棋 · $(status)\\n",color:"gold"},{text:"不限时",color:"gray"}]')
    put('admin/abort', '''
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[围棋] 同维度 8 格内没有正在运行的围棋牌桌。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function weiqi:game/abort
''')
    put('log', '$tellraw @a[tag=ct.debug] {text:"[围棋 Debug] $(text)",color:"gray"}')
    print('Generated weiqi lifecycle, seating, scoring workflow, clocks and review.')


if __name__ == '__main__':
    main()
