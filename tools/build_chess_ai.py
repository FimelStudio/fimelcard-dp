"""Build the bounded, table-local vanilla chess opponent.

No search writes the real board, clocks, rights or history. Each tick reconstructs
the engine cache from this controller's markers. Hard searches the four best
heuristic candidates and every legal reply (a bounded two-ply beam search).
"""
from pathlib import Path
from textwrap import dedent


def candidates(source, kind):
    f, r = source % 8, source // 8
    def sq(x, y):
        return y * 8 + x if 0 <= x < 8 and 0 <= y < 8 else None
    if kind == 1:
        return sorted({v for d in (-1, 1) for v in
                       (sq(f, r+d), sq(f, r+2*d), sq(f-1, r+d), sq(f+1, r+d)) if v is not None})
    if kind in (2, 6):
        jumps = [(1,2),(2,1),(-1,2),(-2,1),(1,-2),(2,-1),(-1,-2),(-2,-1)] if kind == 2 else [(a,b) for a in (-1,0,1) for b in (-1,0,1) if a or b]
        result = {sq(f+a,r+b) for a,b in jumps} - {None}
        if kind == 6 and source in (4,60):
            result.update((source-2,source+2))
        return sorted(result)
    directions = ([(1,1),(1,-1),(-1,1),(-1,-1)] if kind in (3,5) else []) + ([(1,0),(-1,0),(0,1),(0,-1)] if kind in (4,5) else [])
    return sorted({sq(f+a*d,r+b*d) for a,b in directions for d in range(1,8)} - {None})


def build(root):
    root = Path(root)
    # Callers normally pass the data/chess/function root.
    if root.name != 'function':
        root = root / 'data/chess/function'
    def put(name, body):
        dest = root / 'ai' / (name+'.mcfunction')
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text('\n'.join(line.strip() for line in dedent(body).strip().splitlines())+'\n', encoding='utf-8')
    put('reset', '''
        # 只清理本桌搜索；提交走法后调用时不改规则引擎的临时分数。
        scoreboard players set @s ch_aistate 0
        scoreboard players set @s ch_aiwait 0
        scoreboard players set @s ch_aiepoch -1
        data remove entity @s data.chess.ai
    ''')
    put('tick', '''
        execute unless score @s ct_state matches 1 run return run function chess:ai/reset
        execute unless score @s ch_state matches 1 run return 0
        execute unless score @s ch_bot matches -1 unless score @s ch_bot matches 1 run return run function chess:ai/reset
        execute unless score @s ch_turn = @s ch_bot run return run function chess:ai/reset
        execute if score @s ch_aistate matches 1.. unless score @s ch_aiepoch = @s ch_epoch run return run function chess:ai/reset
        execute unless score @s ch_level matches 1..3 run scoreboard players set @s ch_level 2
        execute if score @s ch_aiwait matches 1.. run return run scoreboard players remove @s ch_aiwait 1
        function chess:system/context
        function chess:engine/cache
        execute unless score #cache_ok ch_ctx matches 1 run return run function chess:ai/reset
        execute if score @s ch_aistate matches 0 run return run function chess:ai/begin
        execute if score @s ch_aistate matches 1 run return run function chess:ai/root_tick
        execute if score @s ch_aistate matches 2 run return run function chess:ai/reply_tick
        return run function chess:ai/reset
    ''')
    put('begin', '''
        scoreboard players set @s ch_aistate 1
        scoreboard players set @s ch_aiwait 4
        scoreboard players operation @s ch_aiepoch = @s ch_epoch
        data modify entity @s data.chess.ai set value {queue:[],best:[{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000},{f:-1,t:-1,score:-10000000}],winner:{f:-1,t:-1,score:-10000000},seen:0,replies:0,replymax:0}
        function chess:ai/build_queue
    ''')
    queue = ['data modify entity @s data.chess.ai.queue set value []']
    for source in range(64):
        queue += [f'scoreboard players operation #ai_kind ch_ctx = #b{source} ch_ctx',
                  'scoreboard players operation #ai_kind ch_ctx *= #side ch_ctx']
        for kind in range(1,7):
            queue += [f'execute if score #ai_kind ch_ctx matches {kind} run function chess:ai/queue/s{source}_k{kind}']
            moves = ','.join(f'{{f:{source},t:{target}}}' for target in candidates(source,kind))
            put(f'queue/s{source}_k{kind}', f'data modify entity @s data.chess.ai.batch set value [{moves}]\nfunction chess:ai/flatten_queue')
    # 通过 [] 把候选列表中的复合项逐个追加，避免嵌套 NBT 列表。
    put('flatten_queue', '''
        data modify entity @s data.chess.ai.queue append from entity @s data.chess.ai.batch[]
        data remove entity @s data.chess.ai.batch
    ''')
    put('build_queue', '\n'.join(queue))
    put('root_tick', '\n'.join('execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe' for _ in range(16)) + '''
        execute if data entity @s data.chess.ai.queue[0] run return 0
        execute if score @s ch_level matches 3 run return run function chess:ai/start_reply
        data modify entity @s data.chess.ai.winner set from entity @s data.chess.ai.best[0]
        return run function chess:ai/play
    ''')
    put('root_probe', '''
        execute store result score #from ch_ctx run data get entity @s data.chess.ai.queue[0].f
        execute store result score #to ch_ctx run data get entity @s data.chess.ai.queue[0].t
        data remove entity @s data.chess.ai.queue[0]
        scoreboard players set #promo ch_ctx 5
        function chess:engine/check_move
        execute unless score #legal ch_ctx matches 1 run return 0
        execute if score @s ch_level matches 1 run return run function chess:ai/random_legal
        function chess:ai/score_move
        function chess:ai/consider
    ''')
    put('random_legal', '''
        execute store result score #ai_seen ch_ctx run data get entity @s data.chess.ai.seen
        scoreboard players add #ai_seen ch_ctx 1
        execute store result entity @s data.chess.ai.seen int 1 run scoreboard players get #ai_seen ch_ctx
        execute store result score #ai_random ch_ctx run random value 0..2147483647
        scoreboard players operation #ai_random ch_ctx %= #ai_seen ch_ctx
        execute unless score #ai_random ch_ctx matches 0 run return 0
        data modify entity @s data.chess.ai.best[0] set value {f:0,t:0,score:0}
        execute store result entity @s data.chess.ai.best[0].f int 1 run scoreboard players get #from ch_ctx
        execute store result entity @s data.chess.ai.best[0].t int 1 run scoreboard players get #to ch_ctx
    ''')
    put('value', '''
        scoreboard players set #ai_value ch_ctx 0
        execute if score #ai_kind ch_ctx matches 1 run scoreboard players set #ai_value ch_ctx 100
        execute if score #ai_kind ch_ctx matches 2 run scoreboard players set #ai_value ch_ctx 320
        execute if score #ai_kind ch_ctx matches 3 run scoreboard players set #ai_value ch_ctx 330
        execute if score #ai_kind ch_ctx matches 4 run scoreboard players set #ai_value ch_ctx 500
        execute if score #ai_kind ch_ctx matches 5 run scoreboard players set #ai_value ch_ctx 900
        execute if score #ai_kind ch_ctx matches 6 run scoreboard players set #ai_value ch_ctx 20000
    ''')
    put('gain', '''
        scoreboard players operation #ai_kind ch_ctx = #target ch_ctx
        execute if score #ai_kind ch_ctx matches ..-1 run scoreboard players operation #ai_kind ch_ctx *= #minus ch_ctx
        execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run scoreboard players set #ai_kind ch_ctx 1
        function chess:ai/value
        scoreboard players set #ai_ten ch_ctx 10
        scoreboard players operation #ai_score ch_ctx = #ai_value ch_ctx
        scoreboard players operation #ai_score ch_ctx *= #ai_ten ch_ctx
        execute if score #promotion ch_ctx matches 1 run scoreboard players add #ai_score ch_ctx 8000
    ''')
    put('score_move', '''
        function chess:ai/gain
        # 优先考虑子力交换，再给占中、发展兵和易位少量加分。
        execute store result storage chess:ai pos.f int 1 run scoreboard players get #from ch_ctx
        execute store result storage chess:ai pos.t int 1 run scoreboard players get #to ch_ctx
        function chess:ai/position with storage chess:ai pos
        scoreboard players operation #ai_score ch_ctx += #ai_center_to ch_ctx
        scoreboard players operation #ai_score ch_ctx -= #ai_center_from ch_ctx
        execute if score #kind ch_ctx matches 1 run function chess:ai/pawn_advance
        execute if score #rook_from ch_ctx matches 0..63 run scoreboard players add #ai_score ch_ctx 70
        # 在临时棋盘上检查目标格安全；结束后完整还原，不修改真实棋局。
        function chess:ai/apply_checked
        scoreboard players operation #attack_sq ch_ctx = #to ch_ctx
        scoreboard players operation #attacker ch_ctx = #side ch_ctx
        scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
        function chess:engine/attack
        execute if score #attacked ch_ctx matches 1 run function chess:ai/safety_penalty
        execute if score @s ch_level matches 3 run function chess:ai/check_bonus
        function chess:ai/restore_checked
    ''')
    put('check_bonus', '''
        scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
        execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
        scoreboard players operation #attacker ch_ctx = #side ch_ctx
        function chess:engine/attack
        execute if score #attacked ch_ctx matches 1 run scoreboard players add #ai_score ch_ctx 250
    ''')
    for i in range(64):
        value = (min(i%8,7-i%8)+min(i//8,7-i//8))*8
        put(f'center/s{i}', f'scoreboard players set #ai_center ch_ctx {value}')
    put('position', '''
        $function chess:ai/center/s$(f)
        scoreboard players operation #ai_center_from ch_ctx = #ai_center ch_ctx
        $function chess:ai/center/s$(t)
        scoreboard players operation #ai_center_to ch_ctx = #ai_center ch_ctx
    ''')
    put('pawn_advance', '''
        scoreboard players operation #ai_advance ch_ctx = #to ch_ctx
        scoreboard players operation #ai_advance ch_ctx -= #from ch_ctx
        scoreboard players operation #ai_advance ch_ctx *= #side ch_ctx
        scoreboard players operation #ai_score ch_ctx += #ai_advance ch_ctx
    ''')
    put('safety_penalty', '''
        scoreboard players operation #ai_kind ch_ctx = #placed ch_ctx
        execute if score #ai_kind ch_ctx matches ..-1 run scoreboard players operation #ai_kind ch_ctx *= #minus ch_ctx
        function chess:ai/value
        scoreboard players set #ai_six ch_ctx 6
        scoreboard players operation #ai_value ch_ctx *= #ai_six ch_ctx
        scoreboard players operation #ai_score ch_ctx -= #ai_value ch_ctx
    ''')
    put('apply_checked', '''
        function chess:engine/apply_cache with storage chess:engine scratch
        execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_remove with storage chess:engine scratch
        execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_apply with storage chess:engine scratch
    ''')
    put('restore_checked', '''
        function chess:engine/restore_cache with storage chess:engine scratch
        execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_restore with storage chess:engine scratch
        execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_restore with storage chess:engine scratch
    ''')
    consider = ['data modify entity @s data.chess.ai.candidate set value {f:0,t:0,score:0}',
                'execute store result entity @s data.chess.ai.candidate.f int 1 run scoreboard players get #from ch_ctx',
                'execute store result entity @s data.chess.ai.candidate.t int 1 run scoreboard players get #to ch_ctx',
                'execute store result entity @s data.chess.ai.candidate.score int 1 run scoreboard players get #ai_score ch_ctx']
    for slot in range(4):
        consider += [f'execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.best[{slot}].score',
                     f'execute if score #ai_score ch_ctx > #ai_best ch_ctx run return run function chess:ai/insert{slot}']
        put(f'insert{slot}', '\n'.join(f'data modify entity @s data.chess.ai.best[{i}] set from entity @s data.chess.ai.best[{i-1}]' for i in range(3,slot,-1)) + f'\ndata modify entity @s data.chess.ai.best[{slot}] set from entity @s data.chess.ai.candidate')
    put('consider','\n'.join(consider))
    put('start_reply', '''
        execute unless data entity @s data.chess.ai.best[0] run return run function chess:ai/play
        execute store result score #ai_source ch_ctx run data get entity @s data.chess.ai.best[0].f
        execute unless score #ai_source ch_ctx matches 0..63 run return run function chess:ai/play
        data modify entity @s data.chess.ai.current set from entity @s data.chess.ai.best[0]
        data remove entity @s data.chess.ai.best[0]
        data modify entity @s data.chess.ai.replies set value 0
        data modify entity @s data.chess.ai.replymax set value 0
        scoreboard players set @s ch_aistate 2
        function chess:engine/cache
        function chess:ai/apply_root
        execute unless score #legal ch_ctx matches 1 run return run function chess:ai/reset
        function chess:ai/build_queue
    ''')
    # 原函数最后一行会写回真实易位权；搜索只复用此前的缓存计算。
    rights = (root/'engine/update_rights.mcfunction').read_text(encoding='utf-8').splitlines()
    put('rights', '\n'.join(line for line in rights if not line.startswith('scoreboard players operation @s ')))
    put('apply_root', '''
        execute store result score #from ch_ctx run data get entity @s data.chess.ai.current.f
        execute store result score #to ch_ctx run data get entity @s data.chess.ai.current.t
        scoreboard players set #promo ch_ctx 5
        function chess:engine/check_move
        execute unless score #legal ch_ctx matches 1 run return 0
        function chess:ai/apply_checked
        execute if score #piece ch_ctx matches 6 run scoreboard players operation #wking ch_ctx = #to ch_ctx
        execute if score #piece ch_ctx matches -6 run scoreboard players operation #bking ch_ctx = #to ch_ctx
        function chess:ai/rights
        scoreboard players set #ep ch_ctx -1
        scoreboard players operation #ai_distance ch_ctx = #to ch_ctx
        scoreboard players operation #ai_distance ch_ctx -= #from ch_ctx
        execute if score #kind ch_ctx matches 1 if score #ai_distance ch_ctx matches 16 run function chess:ai/ep_white
        execute if score #kind ch_ctx matches 1 if score #ai_distance ch_ctx matches -16 run function chess:ai/ep_black
        scoreboard players operation #side ch_ctx *= #minus ch_ctx
        scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
        execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
        scoreboard players operation #attacker ch_ctx = #side ch_ctx
        scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
        function chess:engine/attack
        scoreboard players operation #ai_checked ch_ctx = #attacked ch_ctx
    ''')
    for color, operation in [('white','add'),('black','remove')]:
        put('ep_'+color,f'scoreboard players operation #ep ch_ctx = #from ch_ctx\nscoreboard players {operation} #ep ch_ctx 8')
    put('reply_tick', '''
        function chess:ai/apply_root
        execute unless score #legal ch_ctx matches 1 run return run function chess:ai/reset
    ''' + '\n'.join('execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe' for _ in range(16)) + '''
        execute if data entity @s data.chess.ai.queue[0] run return 0
        return run function chess:ai/finish_reply
    ''')
    put('reply_probe', '''
        execute store result score #from ch_ctx run data get entity @s data.chess.ai.queue[0].f
        execute store result score #to ch_ctx run data get entity @s data.chess.ai.queue[0].t
        data remove entity @s data.chess.ai.queue[0]
        scoreboard players set #promo ch_ctx 5
        function chess:engine/check_move
        execute unless score #legal ch_ctx matches 1 run return 0
        execute store result score #ai_replies ch_ctx run data get entity @s data.chess.ai.replies
        scoreboard players add #ai_replies ch_ctx 1
        execute store result entity @s data.chess.ai.replies int 1 run scoreboard players get #ai_replies ch_ctx
        function chess:ai/gain
        execute store result score #ai_replymax ch_ctx run data get entity @s data.chess.ai.replymax
        execute if score #ai_score ch_ctx > #ai_replymax ch_ctx store result entity @s data.chess.ai.replymax int 1 run scoreboard players get #ai_score ch_ctx
    ''')
    put('finish_reply', '''
        execute store result score #ai_score ch_ctx run data get entity @s data.chess.ai.current.score
        execute store result score #ai_replymax ch_ctx run data get entity @s data.chess.ai.replymax
        scoreboard players operation #ai_score ch_ctx -= #ai_replymax ch_ctx
        execute store result score #ai_replies ch_ctx run data get entity @s data.chess.ai.replies
        execute if score #ai_replies ch_ctx matches 0 if score #ai_checked ch_ctx matches 1 run scoreboard players set #ai_score ch_ctx 1000000
        execute if score #ai_replies ch_ctx matches 0 if score #ai_checked ch_ctx matches 0 run scoreboard players set #ai_score ch_ctx 0
        execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.winner.score
        execute if score #ai_score ch_ctx > #ai_best ch_ctx run function chess:ai/choose_reply
        return run function chess:ai/start_reply
    ''')
    put('choose_reply', '''
        data modify entity @s data.chess.ai.winner set from entity @s data.chess.ai.current
        execute store result entity @s data.chess.ai.winner.score int 1 run scoreboard players get #ai_score ch_ctx
    ''')
    put('play', '''
        execute unless score @s ch_aiepoch = @s ch_epoch run return run function chess:ai/reset
        execute unless score @s ch_turn = @s ch_bot run return run function chess:ai/reset
        execute unless score @s ct_state matches 1 run return run function chess:ai/reset
        execute unless score @s ch_state matches 1 run return run function chess:ai/reset
        execute store result score #ai_source ch_ctx run data get entity @s data.chess.ai.winner.f
        execute unless score #ai_source ch_ctx matches 0..63 run return run function chess:ai/no_move
        function chess:game/snapshot
        execute store result score #from ch_ctx run data get entity @s data.chess.ai.winner.f
        execute store result score #to ch_ctx run data get entity @s data.chess.ai.winner.t
        scoreboard players set #promo ch_ctx 5
        function chess:engine/try_move
        execute unless score #legal ch_ctx matches 1 run function chess:ai/reset
    ''')
    put('no_move', '''
        function chess:ai/reset
        function chess:engine/evaluate
        execute if score @s ch_result matches 1.. run function chess:game/finish
    ''')


if __name__ == '__main__':
    build(Path(__file__).resolve().parents[1] / 'data/chess/function')
