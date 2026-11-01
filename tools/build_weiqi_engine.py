# -*- coding: utf-8 -*-
"""围棋纯规则：提子、禁自杀、位置超级劫、悔棋、复盘和中国数子法。

盘面以 19 个三进制行整数保存；哈希只筛选历史，禁止重复前仍逐项精确比较。
洪泛只遍历四个邻点，不生成格子交互实体，不在 tick 中运行。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1] / 'data/weiqi/function/engine'
OBJECTIVES = {name: 'dummy' for name in '''go_ctx go_sq go_file go_rank go_piece go_dead
go_eff go_backup go_pow go_pow2 go_owner go_checked go_size go_turn go_moves go_passes
go_bcap go_wcap go_komi go_result go_barea go_warea go_bterrit go_wterrit go_neutral
go_bscore go_wscore go_btime go_wtime go_bdist go_wdist'''.split()}


def put(name, value):
    path = ROOT / (name + '.mcfunction')
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(('\n'.join(value) if isinstance(value, list) else value).strip() + '\n', encoding='utf-8')


def neighbors(sq):
    file, rank = sq % 19, sq // 19
    return ([sq-1] if file else []) + ([sq+1] if file < 18 else []) + ([sq-19] if rank else []) + ([sq+19] if rank < 18 else [])


def main():
    put('install', [f'scoreboard objectives add {name} {kind}' for name, kind in OBJECTIVES.items()] + ['function weiqi:engine/constants'])
    put('constants', '''
scoreboard players set #minus go_ctx -1
scoreboard players set #two go_ctx 2
scoreboard players set #three go_ctx 3
scoreboard players set #nineteen go_ctx 19
scoreboard players set #thirtyone go_ctx 31
''')
    put('init_board', '''
function weiqi:engine/constants
scoreboard players set @e[tag=go.board] go_piece 0
scoreboard players set @e[tag=go.board] go_dead 0
scoreboard players set @e[tag=go.board] go_owner 0
scoreboard players set @e[tag=go.board] go_eff 0
scoreboard players set @s go_turn 1
scoreboard players set @s go_moves 0
scoreboard players set @s go_passes 0
scoreboard players set @s go_bcap 0
scoreboard players set @s go_wcap 0
scoreboard players set @s go_result 0
data modify entity @s data.weiqi.history set value []
data modify entity @s data.weiqi.positions set value []
data modify entity @s data.weiqi.last set value {sq:-1,side:0,captured:[],pass:1b}
function weiqi:engine/init_weights
function weiqi:engine/encode
function weiqi:engine/snapshot
''')
    put('init_weights', [line for file in range(19) for line in (
        f'execute as @e[tag=go.board,scores={{go_file={file}}}] run scoreboard players set @s go_pow {3**file}',
        f'execute as @e[tag=go.board,scores={{go_file={file}}}] run scoreboard players set @s go_pow2 {2*3**file}',
    )])
    # 每行使用一个服务端整数而非逐格生成 NBT；3^19-1 仍在有符号32位范围。
    encode = ['data modify storage weiqi:runtime position set value {hash:0,board:[' + ','.join(['0']*19) + ']}', 'scoreboard players set #hash go_ctx 0']
    for rank in range(19):
        encode += [
            f'scoreboard players set #row{rank} go_ctx 0',
            f'execute as @e[tag=go.board,scores={{go_rank={rank},go_piece=1}}] run scoreboard players operation #row{rank} go_ctx += @s go_pow',
            f'execute as @e[tag=go.board,scores={{go_rank={rank},go_piece=-1}}] run scoreboard players operation #row{rank} go_ctx += @s go_pow2',
            f'execute store result storage weiqi:runtime position.board[{rank}] int 1 run scoreboard players get #row{rank} go_ctx',
            'scoreboard players operation #hash go_ctx *= #thirtyone go_ctx',
            f'scoreboard players operation #hash go_ctx += #row{rank} go_ctx',
        ]
    encode += ['execute store result storage weiqi:runtime position.hash int 1 run scoreboard players get #hash go_ctx']
    put('encode', encode)
    put('snapshot', '''
# history[0] 是开局状态；pass 也有快照，故回退时两张表始终等长。
data modify storage weiqi:runtime snapshot set value {board:[],turn:1,moves:0,passes:0,bcap:0,wcap:0,btime:0,wtime:0,last:{}}
data modify storage weiqi:runtime snapshot.board set from storage weiqi:runtime position.board
data modify storage weiqi:runtime snapshot.last set from entity @s data.weiqi.last
execute store result storage weiqi:runtime snapshot.turn int 1 run scoreboard players get @s go_turn
execute store result storage weiqi:runtime snapshot.moves int 1 run scoreboard players get @s go_moves
execute store result storage weiqi:runtime snapshot.passes int 1 run scoreboard players get @s go_passes
execute store result storage weiqi:runtime snapshot.bcap int 1 run scoreboard players get @s go_bcap
execute store result storage weiqi:runtime snapshot.wcap int 1 run scoreboard players get @s go_wcap
execute store result storage weiqi:runtime snapshot.btime int 1 run scoreboard players get @s go_btime
execute store result storage weiqi:runtime snapshot.wtime int 1 run scoreboard players get @s go_wtime
data modify entity @s data.weiqi.history append from storage weiqi:runtime snapshot
data modify entity @s data.weiqi.positions append from storage weiqi:runtime position
data modify entity @s data.weiqi.position set from storage weiqi:runtime position.board
''')
    put('try_move', '''
scoreboard players set #commit go_ctx 1
function weiqi:engine/attempt
''')
    put('check_move', '''
# 与正式落子执行相同规则；只保留返回分数，全部持久盘面均回滚。
scoreboard players set #commit go_ctx 0
function weiqi:engine/attempt
''')
    put('attempt', '''
function weiqi:engine/constants
scoreboard players set #legal go_ctx 0
scoreboard players set #error go_ctx 1
scoreboard players set #captured go_ctx 0
scoreboard players operation #side go_ctx = @s go_turn
execute unless score #side go_ctx matches -1 unless score #side go_ctx matches 1 run return 0
execute unless score #to go_ctx matches 0..360 run return 0
execute store result storage weiqi:runtime move.sq int 1 run scoreboard players get #to go_ctx
function weiqi:engine/attempt_at with storage weiqi:runtime move
''')
    put('attempt_at', '''
$execute unless entity @e[tag=go.board,scores={go_sq=$(sq)},limit=1] run return 0
scoreboard players set #error go_ctx 2
$execute unless score @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece matches 0 run return 0
execute as @e[tag=go.board] run scoreboard players operation @s go_backup = @s go_piece
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_piece
data modify storage weiqi:runtime captured set value []
$scoreboard players operation @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece = #side go_ctx
$scoreboard players operation @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_eff = #side go_ctx
$function weiqi:engine/capture/at_$(sq)
scoreboard players operation #seed go_ctx = #to go_ctx
scoreboard players operation #color go_ctx = #side go_ctx
function weiqi:engine/group/start
scoreboard players operation #liberties go_ctx = #libs go_ctx
scoreboard players set #error go_ctx 3
execute if score #libs go_ctx matches 1.. run scoreboard players set #legal go_ctx 1
execute if score #legal go_ctx matches 1 run function weiqi:engine/encode
execute if score #legal go_ctx matches 1 run function weiqi:engine/superko/filter with storage weiqi:runtime position
execute if score #legal go_ctx matches 1 if score #commit go_ctx matches 1 run function weiqi:engine/commit
execute if score #legal go_ctx matches 0 run function weiqi:engine/rollback
execute if score #commit go_ctx matches 0 run function weiqi:engine/rollback
execute if score #legal go_ctx matches 1 run scoreboard players set #error go_ctx 0
function weiqi:engine/group/clear
''')
    put('rollback', '''
execute as @e[tag=go.board] run scoreboard players operation @s go_piece = @s go_backup
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_backup
''')
    put('commit', '''
scoreboard players add @s go_moves 1
scoreboard players set @s go_passes 0
execute if score #side go_ctx matches 1 run scoreboard players operation @s go_bcap += #captured go_ctx
execute if score #side go_ctx matches -1 run scoreboard players operation @s go_wcap += #captured go_ctx
scoreboard players operation @s go_turn *= #minus go_ctx
data modify entity @s data.weiqi.last set value {sq:-1,side:0,captured:[],pass:0b}
execute store result entity @s data.weiqi.last.sq int 1 run scoreboard players get #to go_ctx
execute store result entity @s data.weiqi.last.side int 1 run scoreboard players get #side go_ctx
data modify entity @s data.weiqi.last.captured set from storage weiqi:runtime captured
function weiqi:engine/snapshot
''')
    put('group/clear', [f'tag @e[tag=go.board,tag=go.{tag}] remove go.{tag}' for tag in ('front', 'seen', 'group', 'lib')])
    put('group/start', '''
function weiqi:engine/group/clear
scoreboard players set #border_black go_ctx 0
scoreboard players set #border_white go_ctx 0
scoreboard players set #count go_ctx 0
execute store result storage weiqi:runtime seed.sq int 1 run scoreboard players get #seed go_ctx
function weiqi:engine/group/seed with storage weiqi:runtime seed
function weiqi:engine/group/loop
execute store result score #libs go_ctx if entity @e[tag=go.board,tag=go.lib]
''')
    put('group/seed', '''
$tag @e[tag=go.board,scores={go_sq=$(sq)},limit=1] add go.front
$tag @e[tag=go.board,scores={go_sq=$(sq)},limit=1] add go.seen
''')
    put('group/loop', '''
execute as @e[tag=go.board,tag=go.front,limit=1] run function weiqi:engine/group/visit
execute if entity @e[tag=go.board,tag=go.front] run function weiqi:engine/group/loop
''')
    put('group/visit', '''
tag @s remove go.front
tag @s add go.group
scoreboard players add #count go_ctx 1
execute store result storage weiqi:runtime node.sq int 1 run scoreboard players get @s go_sq
function weiqi:engine/group/dispatch with storage weiqi:runtime node
''')
    put('group/dispatch', '$function weiqi:engine/group/at_$(sq)')
    put('group/neighbor', '''
execute if score @s go_eff matches 0 run tag @s add go.lib
execute if score #color go_ctx matches 0 if score @s go_eff matches 1 run scoreboard players set #border_black go_ctx 1
execute if score #color go_ctx matches 0 if score @s go_eff matches -1 run scoreboard players set #border_white go_ctx 1
execute if score @s go_eff = #color go_ctx unless entity @s[tag=go.seen] run function weiqi:engine/group/enqueue
''')
    put('group/enqueue', 'tag @s add go.seen\ntag @s add go.front')
    for sq in range(361):
        put('group/at_'+str(sq), [f'execute as @e[tag=go.board,scores={{go_sq={other}}},limit=1] run function weiqi:engine/group/neighbor' for other in neighbors(sq)])
        put('capture/at_'+str(sq), [f'execute as @e[tag=go.board,scores={{go_sq={other}}},limit=1] unless score @s go_eff matches 0 unless score @s go_eff = #side go_ctx run function weiqi:engine/capture/group' for other in neighbors(sq)])
    put('capture/group', '''
scoreboard players operation #seed go_ctx = @s go_sq
scoreboard players operation #color go_ctx = @s go_eff
function weiqi:engine/group/start
execute if score #libs go_ctx matches 0 as @e[tag=go.board,tag=go.group] run function weiqi:engine/capture/remove
''')
    put('capture/remove', '''
scoreboard players set @s go_piece 0
scoreboard players set @s go_eff 0
scoreboard players add #captured go_ctx 1
execute store result storage weiqi:runtime captured_sq int 1 run scoreboard players get @s go_sq
data modify storage weiqi:runtime captured append from storage weiqi:runtime captured_sq
''')
    put('superko/filter', '''
# hash 仅用于筛选；候选仍比较完整19行数组，不因哈希碰撞拒绝落子。
data modify storage weiqi:runtime candidates set value []
$data modify storage weiqi:runtime candidates append from entity @s data.weiqi.positions[{hash:$(hash)}]
execute if data storage weiqi:runtime candidates[0] run function weiqi:engine/superko/compare
''')
    put('superko/compare', '''
data modify storage weiqi:runtime comparison set from storage weiqi:runtime candidates[0].board
execute store success score #different go_ctx run data modify storage weiqi:runtime comparison set from storage weiqi:runtime position.board
execute if score #different go_ctx matches 0 run scoreboard players set #legal go_ctx 0
execute if score #different go_ctx matches 0 run scoreboard players set #error go_ctx 4
data remove storage weiqi:runtime candidates[0]
execute if score #legal go_ctx matches 1 if data storage weiqi:runtime candidates[0] run function weiqi:engine/superko/compare
''')
    put('pass', '''
function weiqi:engine/constants
scoreboard players operation #side go_ctx = @s go_turn
scoreboard players operation @s go_turn *= #minus go_ctx
scoreboard players add @s go_moves 1
scoreboard players add @s go_passes 1
data modify entity @s data.weiqi.last set value {sq:-1,side:0,captured:[],pass:1b}
execute store result entity @s data.weiqi.last.side int 1 run scoreboard players get #side go_ctx
function weiqi:engine/encode
function weiqi:engine/snapshot
scoreboard players set #legal go_ctx 1
scoreboard players set #error go_ctx 0
''')
    put('undo', '''
scoreboard players set #ok go_ctx 0
execute unless data entity @s data.weiqi.history[1] run return 0
data remove entity @s data.weiqi.history[-1]
data remove entity @s data.weiqi.positions[-1]
data modify storage weiqi:runtime snapshot set from entity @s data.weiqi.history[-1]
function weiqi:engine/restore
scoreboard players set #ok go_ctx 1
''')
    put('review', '''
scoreboard players set #ok go_ctx 0
execute unless score #frame go_ctx matches 0.. run return 0
execute store result storage weiqi:runtime review.frame int 1 run scoreboard players get #frame go_ctx
function weiqi:engine/review_at with storage weiqi:runtime review
''')
    put('review_at', '''
$execute unless data entity @s data.weiqi.history[$(frame)] run return 0
$data modify storage weiqi:runtime snapshot set from entity @s data.weiqi.history[$(frame)]
function weiqi:engine/restore
scoreboard players set #ok go_ctx 1
''')
    restore = ['function weiqi:engine/constants']
    for rank in range(19):
        restore += [f'execute store result score #row go_ctx run data get storage weiqi:runtime snapshot.board[{rank}]', f'execute as @e[tag=go.board,scores={{go_rank={rank}}}] run function weiqi:engine/decode_cell']
    restore += [f'execute store result score @s go_{field} run data get storage weiqi:runtime snapshot.{field}' for field in ('turn','moves','passes','bcap','wcap','btime','wtime')]
    restore += ['data modify entity @s data.weiqi.last set from storage weiqi:runtime snapshot.last', 'data modify entity @s data.weiqi.position set from storage weiqi:runtime snapshot.board', 'scoreboard players set @e[tag=go.board] go_dead 0', 'scoreboard players set @s go_result 0', 'function weiqi:engine/group/clear']
    put('restore', restore)
    put('decode_cell', '''
scoreboard players operation @s go_piece = #row go_ctx
scoreboard players operation @s go_piece /= @s go_pow
scoreboard players operation @s go_piece %= #three go_ctx
execute if score @s go_piece matches 2 run scoreboard players set @s go_piece -1
scoreboard players operation @s go_eff = @s go_piece
''')
    put('score', '''
# 只把已标死棋子视为空，不改真实盘面；中局估算不会擅自判死。
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_piece
scoreboard players set @e[tag=go.board,scores={go_dead=1}] go_eff 0
execute as @e[tag=go.board] run scoreboard players operation @s go_owner = @s go_eff
scoreboard players set @e[tag=go.board] go_checked 0
execute store result score #black go_ctx if entity @e[tag=go.board,scores={go_eff=1}]
execute store result score #white go_ctx if entity @e[tag=go.board,scores={go_eff=-1}]
scoreboard players set #bterrit go_ctx 0
scoreboard players set #wterrit go_ctx 0
scoreboard players set #neutral go_ctx 0
execute as @e[tag=go.board,scores={go_eff=0}] unless score @s go_checked matches 1 run function weiqi:engine/score_region
scoreboard players operation @s go_bterrit = #bterrit go_ctx
scoreboard players operation @s go_wterrit = #wterrit go_ctx
scoreboard players operation @s go_neutral = #neutral go_ctx
scoreboard players operation @s go_barea = #black go_ctx
scoreboard players operation @s go_warea = #white go_ctx
scoreboard players operation @s go_barea += #bterrit go_ctx
scoreboard players operation @s go_warea += #wterrit go_ctx
scoreboard players operation @s go_bscore = @s go_barea
scoreboard players operation @s go_wscore = @s go_warea
scoreboard players operation @s go_bscore *= #two go_ctx
scoreboard players operation @s go_wscore *= #two go_ctx
scoreboard players operation @s go_wscore += @s go_komi
function weiqi:engine/group/clear
''')
    put('score_region', '''
# execute as 的筛选条件需在函数内复查：前一个洪泛可能已遍历本格。
execute if score @s go_checked matches 1 run return 0
scoreboard players operation #seed go_ctx = @s go_sq
scoreboard players set #color go_ctx 0
function weiqi:engine/group/start
scoreboard players set @e[tag=go.board,tag=go.group] go_checked 1
execute if score #border_black go_ctx matches 1 if score #border_white go_ctx matches 0 run scoreboard players operation #bterrit go_ctx += #count go_ctx
execute if score #border_black go_ctx matches 0 if score #border_white go_ctx matches 1 run scoreboard players operation #wterrit go_ctx += #count go_ctx
execute if score #border_black go_ctx = #border_white go_ctx run scoreboard players operation #neutral go_ctx += #count go_ctx
execute if score #border_black go_ctx matches 1 if score #border_white go_ctx matches 0 run scoreboard players set @e[tag=go.board,tag=go.group] go_owner 1
execute if score #border_black go_ctx matches 0 if score #border_white go_ctx matches 1 run scoreboard players set @e[tag=go.board,tag=go.group] go_owner -1
''')
    # 中局只给局部影响估算，避免第一颗黑子使所有未封闭空点被判为黑地。
    estimate = ['function weiqi:engine/constants', 'scoreboard players set @e[tag=go.board] go_bdist 999',
                'scoreboard players set @e[tag=go.board] go_wdist 999',
                'scoreboard players set @e[tag=go.board,scores={go_piece=1}] go_bdist 0',
                'scoreboard players set @e[tag=go.board,scores={go_piece=-1}] go_wdist 0']
    for side, field in ((1, 'bdist'), (-1, 'wdist')):
        estimate += [f'scoreboard players set #est_side go_ctx {side}']
        # 多保留敌方第四路距离，区分“3比4仅近一步”与“3比5近两步”。
        for layer in range(4):
            estimate += [f'scoreboard players set #est_next go_ctx {layer+1}',
                         f'execute as @e[tag=go.board,scores={{go_{field}={layer}}}] run function weiqi:engine/estimate/visit']
    estimate += ['execute as @e[tag=go.board] run function weiqi:engine/estimate/classify',
                 'execute store result score @s go_barea if entity @e[tag=go.board,scores={go_owner=1}]',
                 'execute store result score @s go_warea if entity @e[tag=go.board,scores={go_owner=-1}]',
                 'execute store result score @s go_bterrit if entity @e[tag=go.board,scores={go_piece=0,go_owner=1}]',
                 'execute store result score @s go_wterrit if entity @e[tag=go.board,scores={go_piece=0,go_owner=-1}]',
                 'execute store result score @s go_neutral if entity @e[tag=go.board,scores={go_piece=0,go_owner=0}]',
                 'scoreboard players operation @s go_bscore = @s go_barea',
                 'scoreboard players operation @s go_wscore = @s go_warea',
                 'scoreboard players operation @s go_bscore *= #two go_ctx',
                 'scoreboard players operation @s go_wscore *= #two go_ctx',
                 'scoreboard players operation @s go_wscore += @s go_komi']
    put('estimate', estimate)
    put('estimate/visit', '''
execute store result storage weiqi:runtime estimate.sq int 1 run scoreboard players get @s go_sq
function weiqi:engine/estimate/dispatch with storage weiqi:runtime estimate
''')
    put('estimate/dispatch', '$function weiqi:engine/estimate/at_$(sq)')
    for sq in range(361):
        put('estimate/at_'+str(sq), [f'execute as @e[tag=go.board,scores={{go_sq={other}}},limit=1] run function weiqi:engine/estimate/neighbor' for other in neighbors(sq)])
    put('estimate/neighbor', '''
execute if score #est_side go_ctx matches 1 if score @s go_bdist > #est_next go_ctx run scoreboard players operation @s go_bdist = #est_next go_ctx
execute if score #est_side go_ctx matches -1 if score @s go_wdist > #est_next go_ctx run scoreboard players operation @s go_wdist = #est_next go_ctx
''')
    put('estimate/classify', '''
# 三路内且至少近两步才暂归属，未定点不加入任何一方估计面积。
scoreboard players operation @s go_owner = @s go_piece
execute unless score @s go_piece matches 0 run return 0
scoreboard players operation #est_gap go_ctx = @s go_wdist
scoreboard players operation #est_gap go_ctx -= @s go_bdist
execute if score @s go_bdist matches ..3 if score #est_gap go_ctx matches 2.. run scoreboard players set @s go_owner 1
execute if score @s go_wdist matches ..3 if score #est_gap go_ctx matches ..-2 run scoreboard players set @s go_owner -1
''')
    put('toggle_dead', '''
scoreboard players set #ok go_ctx 0
execute unless score #to go_ctx matches 0..360 run return 0
execute store result storage weiqi:runtime dead.sq int 1 run scoreboard players get #to go_ctx
function weiqi:engine/toggle_dead_at with storage weiqi:runtime dead
''')
    put('toggle_dead_at', '''
$execute unless entity @e[tag=go.board,scores={go_sq=$(sq)},limit=1] run return 0
$execute if score @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece matches 0 run return 0
execute as @e[tag=go.board] run scoreboard players operation @s go_eff = @s go_piece
scoreboard players operation #seed go_ctx = #to go_ctx
$scoreboard players operation #color go_ctx = @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_piece
scoreboard players set #newdead go_ctx 1
$execute if score @e[tag=go.board,scores={go_sq=$(sq)},limit=1] go_dead matches 1 run scoreboard players set #newdead go_ctx 0
function weiqi:engine/group/start
scoreboard players operation @e[tag=go.board,tag=go.group] go_dead = #newdead go_ctx
scoreboard players operation #changed go_ctx = #count go_ctx
scoreboard players set #ok go_ctx 1
function weiqi:engine/group/clear
''')
    print('围棋纯规则已生成：' + str(len(list(ROOT.rglob('*.mcfunction')))) + ' 个函数。')


if __name__ == '__main__':
    main()
