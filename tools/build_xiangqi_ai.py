"""中国象棋分刻人机：简单随机、普通局面评估、困难四候选与对方应手。

搜索只修改临时棋面，每刻从本桌重新建立缓存，真实提交仍由规则引擎复核。
"""
from pathlib import Path
from textwrap import dedent


def candidates(source, kind):
    f, r = source % 9, source // 9
    def sq(x, y):
        return y * 9 + x if 0 <= x < 9 and 0 <= y < 10 else None
    if kind in (1, 6):
        return sorted({sq(f+a, r+b) for a,b in [(1,0),(-1,0),(0,1),(0,-1)]} - {None})
    if kind == 2:
        jumps = [(1,2),(2,1),(-1,2),(-2,1),(1,-2),(2,-1),(-1,-2),(-2,-1)]
        return sorted({sq(f+a,r+b) for a,b in jumps} - {None})
    if kind in (3, 7):
        step = 2 if kind == 3 else 1
        return sorted({sq(f+a*step,r+b*step) for a,b in [(1,1),(1,-1),(-1,1),(-1,-1)]} - {None})
    return sorted({sq(f+a*d,r+b*d) for a,b in [(1,0),(-1,0),(0,1),(0,-1)] for d in range(1,10)} - {None})


def build(root):
    root = Path(root)
    # Callers normally pass the data/xiangqi/function root.
    if root.name != 'function':
        root = root / 'data/xiangqi/function'
    def put(name, body):
        dest = root / 'ai' / (name+'.mcfunction')
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text('\n'.join(line.strip() for line in dedent(body).strip().splitlines())+'\n', encoding='utf-8')
    put('reset', '''
        # 只清理本桌搜索；提交走法后调用时不改规则引擎的临时分数。
        scoreboard players set @s xq_aistate 0
        scoreboard players set @s xq_aiwait 0
        scoreboard players set @s xq_aiepoch -1
        data remove entity @s data.xiangqi.ai
    ''')
    put('tick', '''
        execute unless score @s ct_state matches 1 run return run function xiangqi:ai/reset
        execute unless score @s xq_state matches 1 run return 0
        execute unless score @s xq_bot matches -1 unless score @s xq_bot matches 1 run return run function xiangqi:ai/reset
        execute unless score @s xq_turn = @s xq_bot run return run function xiangqi:ai/reset
        execute if score @s xq_aistate matches 1.. unless score @s xq_aiepoch = @s xq_epoch run return run function xiangqi:ai/reset
        execute unless score @s xq_level matches 1..3 run scoreboard players set @s xq_level 2
        execute if score @s xq_aiwait matches 1.. run return run scoreboard players remove @s xq_aiwait 1
        function xiangqi:system/context
        function xiangqi:engine/cache
        execute unless score #cache_ok xq_ctx matches 1 run return run function xiangqi:ai/no_move
        execute if score @s xq_aistate matches 0 run return run function xiangqi:ai/begin
        execute if score @s xq_aistate matches 1 run return run function xiangqi:ai/root_tick
        execute if score @s xq_aistate matches 2 run return run function xiangqi:ai/reply_tick
        return run function xiangqi:ai/reset
    ''')
    put('begin', '''
        scoreboard players set @s xq_aistate 1
        scoreboard players set @s xq_aiwait 4
        scoreboard players operation @s xq_aiepoch = @s xq_epoch
        data modify entity @s data.xiangqi.ai set value {queue:[],best:[{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000}],winner:{f:-1,t:-1,score:-10000000},seen:0,replies:0,replymax:0}
        function xiangqi:ai/build_queue
    ''')
    queue = ['data modify entity @s data.xiangqi.ai.queue set value []']
    for source in range(90):
        queue += [f'scoreboard players operation #ai_kind xq_ctx = #b{source} xq_ctx',
                  'scoreboard players operation #ai_kind xq_ctx *= #side xq_ctx']
        for kind in range(1,8):
            queue += [f'execute if score #ai_kind xq_ctx matches {kind} run function xiangqi:ai/queue/s{source}_k{kind}']
            moves = ','.join(f'{{f:{source},t:{target}}}' for target in candidates(source,kind))
            put(f'queue/s{source}_k{kind}', f'data modify entity @s data.xiangqi.ai.batch set value [{moves}]\nfunction xiangqi:ai/flatten_queue')
    # 通过 [] 把候选列表中的复合项逐个追加，避免嵌套 NBT 列表。
    put('flatten_queue', '''
        data modify entity @s data.xiangqi.ai.queue append from entity @s data.xiangqi.ai.batch[]
        data remove entity @s data.xiangqi.ai.batch
    ''')
    put('build_queue', '\n'.join(queue))
    put('root_tick', '\n'.join('execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe' for _ in range(16)) + '''
        execute if data entity @s data.xiangqi.ai.queue[0] run return 0
        execute if score @s xq_level matches 3 run return run function xiangqi:ai/start_reply
        data modify entity @s data.xiangqi.ai.winner set from entity @s data.xiangqi.ai.best[0]
        return run function xiangqi:ai/play
    ''')
    put('root_probe', '''
        execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.queue[0].f
        execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.queue[0].t
        data remove entity @s data.xiangqi.ai.queue[0]
        scoreboard players set #promo xq_ctx 5
        function xiangqi:engine/check_move
        execute unless score #legal xq_ctx matches 1 run return 0
        execute if score @s xq_level matches 1 run return run function xiangqi:ai/random_legal
        function xiangqi:ai/score_move
        function xiangqi:ai/consider
    ''')
    put('random_legal', '''
        execute store result score #ai_seen xq_ctx run data get entity @s data.xiangqi.ai.seen
        scoreboard players add #ai_seen xq_ctx 1
        execute store result entity @s data.xiangqi.ai.seen int 1 run scoreboard players get #ai_seen xq_ctx
        execute store result score #ai_random xq_ctx run random value 0..2147483647
        scoreboard players operation #ai_random xq_ctx %= #ai_seen xq_ctx
        execute unless score #ai_random xq_ctx matches 0 run return 0
        data modify entity @s data.xiangqi.ai.best[0] set value {f:0,t:0,score:0}
        execute store result entity @s data.xiangqi.ai.best[0].f int 1 run scoreboard players get #from xq_ctx
        execute store result entity @s data.xiangqi.ai.best[0].t int 1 run scoreboard players get #to xq_ctx
    ''')
    put('value', '''
        scoreboard players set #ai_value xq_ctx 0
        execute if score #ai_kind xq_ctx matches 1 run scoreboard players set #ai_value xq_ctx 100
        execute if score #ai_kind xq_ctx matches 2 run scoreboard players set #ai_value xq_ctx 400
        execute if score #ai_kind xq_ctx matches 3 run scoreboard players set #ai_value xq_ctx 200
        execute if score #ai_kind xq_ctx matches 4 run scoreboard players set #ai_value xq_ctx 900
        execute if score #ai_kind xq_ctx matches 5 run scoreboard players set #ai_value xq_ctx 450
        execute if score #ai_kind xq_ctx matches 6 run scoreboard players set #ai_value xq_ctx 20000
        execute if score #ai_kind xq_ctx matches 7 run scoreboard players set #ai_value xq_ctx 200
    ''')
    put('gain', '''
        scoreboard players operation #ai_kind xq_ctx = #target xq_ctx
        execute if score #ai_kind xq_ctx matches ..-1 run scoreboard players operation #ai_kind xq_ctx *= #minus xq_ctx
        function xiangqi:ai/value
        scoreboard players set #ai_ten xq_ctx 10
        scoreboard players operation #ai_score xq_ctx = #ai_value xq_ctx
        scoreboard players operation #ai_score xq_ctx *= #ai_ten xq_ctx
    ''')
    put('score_move', '''
        function xiangqi:ai/gain
        # 优先考虑子力交换，再给占中与兵卒发展少量加分。
        execute store result storage xiangqi:ai pos.f int 1 run scoreboard players get #from xq_ctx
        execute store result storage xiangqi:ai pos.t int 1 run scoreboard players get #to xq_ctx
        function xiangqi:ai/position with storage xiangqi:ai pos
        scoreboard players operation #ai_score xq_ctx += #ai_center_to xq_ctx
        scoreboard players operation #ai_score xq_ctx -= #ai_center_from xq_ctx
        execute if score #kind xq_ctx matches 1 run function xiangqi:ai/pawn_advance
        # 在临时棋盘上检查目标格安全；结束后完整还原，不修改真实棋局。
        function xiangqi:ai/apply_checked
        scoreboard players operation #attack_sq xq_ctx = #to xq_ctx
        scoreboard players operation #attacker xq_ctx = #side xq_ctx
        scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
        function xiangqi:engine/attack
        execute if score #attacked xq_ctx matches 1 run function xiangqi:ai/safety_penalty
        execute if score @s xq_level matches 3 run function xiangqi:ai/check_bonus
        function xiangqi:ai/restore_checked
    ''')
    put('check_bonus', '''
        scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
        execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
        scoreboard players operation #attacker xq_ctx = #side xq_ctx
        function xiangqi:engine/attack
        execute if score #attacked xq_ctx matches 1 run scoreboard players add #ai_score xq_ctx 250
    ''')
    for i in range(90):
        value = (min(i%9,8-i%9)+min(i//9,9-i//9))*8
        put(f'center/s{i}', f'scoreboard players set #ai_center xq_ctx {value}')
    put('position', '''
        $function xiangqi:ai/center/s$(f)
        scoreboard players operation #ai_center_from xq_ctx = #ai_center xq_ctx
        $function xiangqi:ai/center/s$(t)
        scoreboard players operation #ai_center_to xq_ctx = #ai_center xq_ctx
    ''')
    put('pawn_advance', '''
        scoreboard players set #ai_nine xq_ctx 9
        scoreboard players operation #ai_from_rank xq_ctx = #from xq_ctx
        scoreboard players operation #ai_from_rank xq_ctx /= #ai_nine xq_ctx
        scoreboard players operation #ai_advance xq_ctx = #to xq_ctx
        scoreboard players operation #ai_advance xq_ctx /= #ai_nine xq_ctx
        scoreboard players operation #ai_advance xq_ctx -= #ai_from_rank xq_ctx
        scoreboard players operation #ai_advance xq_ctx *= #side xq_ctx
        scoreboard players set #ai_twenty xq_ctx 20
        scoreboard players operation #ai_advance xq_ctx *= #ai_twenty xq_ctx
        scoreboard players operation #ai_score xq_ctx += #ai_advance xq_ctx
    ''')
    put('safety_penalty', '''
        scoreboard players operation #ai_kind xq_ctx = #placed xq_ctx
        execute if score #ai_kind xq_ctx matches ..-1 run scoreboard players operation #ai_kind xq_ctx *= #minus xq_ctx
        function xiangqi:ai/value
        scoreboard players set #ai_six xq_ctx 6
        scoreboard players operation #ai_value xq_ctx *= #ai_six xq_ctx
        scoreboard players operation #ai_score xq_ctx -= #ai_value xq_ctx
    ''')
    put('apply_checked', '''
        function xiangqi:engine/apply_cache with storage xiangqi:engine scratch
    ''')
    put('restore_checked', '''
        function xiangqi:engine/restore_cache with storage xiangqi:engine scratch
    ''')
    consider = ['data modify entity @s data.xiangqi.ai.candidate set value {f:0,t:0,score:0}',
                'execute store result entity @s data.xiangqi.ai.candidate.f int 1 run scoreboard players get #from xq_ctx',
                'execute store result entity @s data.xiangqi.ai.candidate.t int 1 run scoreboard players get #to xq_ctx',
                'execute store result entity @s data.xiangqi.ai.candidate.score int 1 run scoreboard players get #ai_score xq_ctx']
    for slot in range(4):
        consider += [f'execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.best[{slot}].score',
                     f'execute if score #ai_score xq_ctx > #ai_best xq_ctx run return run function xiangqi:ai/insert{slot}']
        put(f'insert{slot}', '\n'.join(f'data modify entity @s data.xiangqi.ai.best[{i}] set from entity @s data.xiangqi.ai.best[{i-1}]' for i in range(3,slot,-1)) + f'\ndata modify entity @s data.xiangqi.ai.best[{slot}] set from entity @s data.xiangqi.ai.candidate')
    put('consider','\n'.join(consider))
    put('start_reply', '''
        execute unless data entity @s data.xiangqi.ai.best[0] run return run function xiangqi:ai/play
        execute store result score #ai_source xq_ctx run data get entity @s data.xiangqi.ai.best[0].f
        execute unless score #ai_source xq_ctx matches 0..89 run return run function xiangqi:ai/play
        data modify entity @s data.xiangqi.ai.current set from entity @s data.xiangqi.ai.best[0]
        data remove entity @s data.xiangqi.ai.best[0]
        data modify entity @s data.xiangqi.ai.replies set value 0
        data modify entity @s data.xiangqi.ai.replymax set value 0
        scoreboard players set @s xq_aistate 2
        function xiangqi:engine/cache
        function xiangqi:ai/apply_root
        execute unless score #legal xq_ctx matches 1 run return run function xiangqi:ai/reset
        function xiangqi:ai/build_queue
    ''')
    put('apply_root', '''
        execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.current.f
        execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.current.t
        scoreboard players set #promo xq_ctx 5
        function xiangqi:engine/check_move
        execute unless score #legal xq_ctx matches 1 run return 0
        function xiangqi:ai/apply_checked
        execute if score #piece xq_ctx matches 6 run scoreboard players operation #wking xq_ctx = #to xq_ctx
        execute if score #piece xq_ctx matches -6 run scoreboard players operation #bking xq_ctx = #to xq_ctx
        scoreboard players operation #side xq_ctx *= #minus xq_ctx
        scoreboard players operation #attack_sq xq_ctx = #wking xq_ctx
        execute if score #side xq_ctx matches -1 run scoreboard players operation #attack_sq xq_ctx = #bking xq_ctx
        scoreboard players operation #attacker xq_ctx = #side xq_ctx
        scoreboard players operation #attacker xq_ctx *= #minus xq_ctx
        function xiangqi:engine/attack
        scoreboard players operation #ai_checked xq_ctx = #attacked xq_ctx
    ''')
    put('reply_tick', '''
        function xiangqi:ai/apply_root
        execute unless score #legal xq_ctx matches 1 run return run function xiangqi:ai/reset
    ''' + '\n'.join('execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe' for _ in range(16)) + '''
        execute if data entity @s data.xiangqi.ai.queue[0] run return 0
        return run function xiangqi:ai/finish_reply
    ''')
    put('reply_probe', '''
        execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.queue[0].f
        execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.queue[0].t
        data remove entity @s data.xiangqi.ai.queue[0]
        scoreboard players set #promo xq_ctx 5
        function xiangqi:engine/check_move
        execute unless score #legal xq_ctx matches 1 run return 0
        execute store result score #ai_replies xq_ctx run data get entity @s data.xiangqi.ai.replies
        scoreboard players add #ai_replies xq_ctx 1
        execute store result entity @s data.xiangqi.ai.replies int 1 run scoreboard players get #ai_replies xq_ctx
        function xiangqi:ai/gain
        execute store result score #ai_replymax xq_ctx run data get entity @s data.xiangqi.ai.replymax
        execute if score #ai_score xq_ctx > #ai_replymax xq_ctx store result entity @s data.xiangqi.ai.replymax int 1 run scoreboard players get #ai_score xq_ctx
    ''')
    put('finish_reply', '''
        execute store result score #ai_score xq_ctx run data get entity @s data.xiangqi.ai.current.score
        execute store result score #ai_replymax xq_ctx run data get entity @s data.xiangqi.ai.replymax
        scoreboard players operation #ai_score xq_ctx -= #ai_replymax xq_ctx
        execute store result score #ai_replies xq_ctx run data get entity @s data.xiangqi.ai.replies
        execute if score #ai_replies xq_ctx matches 0 run scoreboard players set #ai_score xq_ctx 1000000
        execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.winner.score
        execute if score #ai_score xq_ctx > #ai_best xq_ctx run function xiangqi:ai/choose_reply
        return run function xiangqi:ai/start_reply
    ''')
    put('choose_reply', '''
        data modify entity @s data.xiangqi.ai.winner set from entity @s data.xiangqi.ai.current
        execute store result entity @s data.xiangqi.ai.winner.score int 1 run scoreboard players get #ai_score xq_ctx
    ''')
    put('play', '''
        execute unless score @s xq_aiepoch = @s xq_epoch run return run function xiangqi:ai/reset
        execute unless score @s xq_turn = @s xq_bot run return run function xiangqi:ai/reset
        execute unless score @s ct_state matches 1 run return run function xiangqi:ai/reset
        execute unless score @s xq_state matches 1 run return run function xiangqi:ai/reset
        execute store result score #ai_source xq_ctx run data get entity @s data.xiangqi.ai.winner.f
        execute unless score #ai_source xq_ctx matches 0..89 run return run function xiangqi:ai/no_move
        function xiangqi:game/snapshot
        execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.winner.f
        execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.winner.t
        scoreboard players set #promo xq_ctx 5
        function xiangqi:engine/try_move
        execute unless score #legal xq_ctx matches 1 run function xiangqi:ai/reset
    ''')
    put('no_move', '''
        function xiangqi:ai/reset
        function xiangqi:engine/evaluate
        execute if score @s xq_result matches 1.. run function xiangqi:game/finish
    ''')


if __name__ == '__main__':
    build(Path(__file__).resolve().parents[1] / 'data/xiangqi/function')
