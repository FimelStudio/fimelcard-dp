"""五子棋三档人机：随机邻域、棋形评分、前三候选的一层威胁应手。

所有搜索只修改刻内假棋盘；每刻最多 12 个候选，真实落子仍经过规则引擎。
这是适合数据包的休闲人机，并非专业五子棋引擎。
"""
from pathlib import Path
from textwrap import dedent
import re

PACK = Path(__file__).resolve().parents[1]
DIRECTIONS = ((1, 0), (0, 1), (1, 1), (1, -1))


def build(root=PACK):
    root=Path(root)
    if root.name != 'function': root=root/'data/gomoku/function'
    def put(name,body):
        path=root/'ai'/(name+'.mcfunction')
        path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text('\n'.join(re.sub(r' {2,}', ' ', line.strip()) for line in dedent(body).strip().splitlines())+'\n',encoding='utf-8')

    put('reset','''
        scoreboard players set @s gm_aistate 0
        scoreboard players set @s gm_aiwait 4
        data remove entity @s data.gomoku.ai
    ''')
    put('tick','''
        execute unless score @s ct_state matches 1 run return run function gomoku:ai/reset
        execute unless score @s gm_state matches 1 run return run function gomoku:ai/reset
        execute unless score @s gm_result matches 0 run return run function gomoku:ai/reset
        execute unless score @s gm_bot matches -1 unless score @s gm_bot matches 1 run return run function gomoku:ai/reset
        execute unless score @s gm_turn = @s gm_bot run return run function gomoku:ai/reset
        execute if score @s gm_aistate matches 1 unless score @s gm_aiepoch = @s gm_epoch run return run function gomoku:ai/reset
        execute unless score @s gm_aistate matches 1 run return run function gomoku:ai/start
        execute if score @s gm_aiwait matches 1.. run return run scoreboard players remove @s gm_aiwait 1
        function gomoku:engine/cache
        execute unless score #cache_ok gm_ctx matches 1 run return run function gomoku:ai/invalid
        execute store result score #stage gm_ctx run data get entity @s data.gomoku.ai.stage
        execute store result score #index gm_ctx run data get entity @s data.gomoku.ai.index
        execute store result score #top0 gm_ctx run data get entity @s data.gomoku.ai.top[0].score
        execute store result score #top1 gm_ctx run data get entity @s data.gomoku.ai.top[1].score
        execute store result score #top2 gm_ctx run data get entity @s data.gomoku.ai.top[2].score
        scoreboard players set #work gm_ctx 12
        execute if score #stage gm_ctx matches 2 run function gomoku:ai/apply_root
        function gomoku:ai/batch
        execute store result entity @s data.gomoku.ai.index int 1 run scoreboard players get #index gm_ctx
        execute if score #index gm_ctx matches 361.. run function gomoku:ai/advance
    ''')
    put('start','''
        scoreboard players set @s gm_aistate 1
        scoreboard players set @s gm_aiwait 4
        scoreboard players operation @s gm_aiepoch = @s gm_epoch
        data modify entity @s data.gomoku.ai set value {stage:1,index:0,root:0,root_sq:-1,chosen:-1,best:-2000000000,reply:0,top:[{sq:-1,score:-1000000000},{sq:-1,score:-1000000000},{sq:-1,score:-1000000000}]}
        execute if score @s gm_moves matches 0 run function gomoku:ai/opening
    ''')
    put('opening','''
        scoreboard players set #two gm_ctx 2
        scoreboard players set #nineteen gm_ctx 19
        scoreboard players operation #center gm_ctx = @s gm_size
        scoreboard players operation #center gm_ctx /= #two gm_ctx
        scoreboard players operation #to gm_ctx = #center gm_ctx
        scoreboard players operation #to gm_ctx *= #nineteen gm_ctx
        scoreboard players operation #to gm_ctx += #center gm_ctx
        execute store result entity @s data.gomoku.ai.chosen int 1 run scoreboard players get #to gm_ctx
        data modify entity @s data.gomoku.ai.stage set value 3
        data modify entity @s data.gomoku.ai.index set value 361
    ''')
    put('batch','''
        execute unless score #index gm_ctx matches 0..360 run return 0
        execute store result storage gomoku:ctx ai.sq int 1 run scoreboard players get #index gm_ctx
        function gomoku:ai/dispatch with storage gomoku:ctx ai
        scoreboard players add #index gm_ctx 1
        scoreboard players remove #work gm_ctx 1
        execute if score #work gm_ctx matches 1.. if score #index gm_ctx matches ..360 run function gomoku:ai/batch
    ''')
    put('dispatch','$function gomoku:ai/cell/$(sq)')
    put('consider','''
        execute unless score #stage gm_ctx matches 1 run return 0
        execute if score #score gm_ctx > #top0 gm_ctx run return run function gomoku:ai/top/0
        execute if score #score gm_ctx > #top1 gm_ctx run return run function gomoku:ai/top/1
        execute if score #score gm_ctx > #top2 gm_ctx run return run function gomoku:ai/top/2
    ''')
    for n in range(3):
        put(f'top/{n}',f'''
            data modify storage gomoku:ctx candidate set value {{sq:0,score:0}}
            execute store result storage gomoku:ctx candidate.sq int 1 run scoreboard players get #candidate gm_ctx
            execute store result storage gomoku:ctx candidate.score int 1 run scoreboard players get #score gm_ctx
            data modify entity @s data.gomoku.ai.top insert {n} from storage gomoku:ctx candidate
            data remove entity @s data.gomoku.ai.top[-1]
            execute store result score #top0 gm_ctx run data get entity @s data.gomoku.ai.top[0].score
            execute store result score #top1 gm_ctx run data get entity @s data.gomoku.ai.top[1].score
            execute store result score #top2 gm_ctx run data get entity @s data.gomoku.ai.top[2].score
        ''')
    put('apply_root','''
        execute store result score #root_sq gm_ctx run data get entity @s data.gomoku.ai.root_sq
        execute store result storage gomoku:ctx root.sq int 1 run scoreboard players get #root_sq gm_ctx
        execute store result storage gomoku:ctx root.side int 1 run scoreboard players get #side gm_ctx
        function gomoku:ai/root_overlay with storage gomoku:ctx root
    ''')
    put('root_overlay','$scoreboard players set #b$(sq) gm_ctx $(side)')
    put('advance','''
        execute if score #stage gm_ctx matches 3 run return run function gomoku:ai/submit
        execute if score #stage gm_ctx matches 1 run return run function gomoku:ai/first_done
        execute if score #stage gm_ctx matches 2 run function gomoku:ai/reply_done
    ''')
    put('first_done','''
        execute store result score #choice gm_ctx run data get entity @s data.gomoku.ai.top[0].sq
        execute store result score #value gm_ctx run data get entity @s data.gomoku.ai.top[0].score
        execute unless score #choice gm_ctx matches 0..360 run return run function gomoku:ai/full
        execute store result entity @s data.gomoku.ai.chosen int 1 run scoreboard players get #choice gm_ctx
        execute unless score @s gm_level matches 3 run return run function gomoku:ai/submit
        execute if score #value gm_ctx matches 100000000.. run return run function gomoku:ai/submit
        data modify entity @s data.gomoku.ai.stage set value 2
        data modify entity @s data.gomoku.ai.root set value 0
        function gomoku:ai/prepare_reply
    ''')
    put('prepare_reply','''
        execute store result score #root gm_ctx run data get entity @s data.gomoku.ai.root
        execute store result storage gomoku:ctx root.index int 1 run scoreboard players get #root gm_ctx
        function gomoku:ai/select_root with storage gomoku:ctx root
        data modify entity @s data.gomoku.ai.index set value 0
        data modify entity @s data.gomoku.ai.reply set value 0
    ''')
    put('select_root','''
        $data modify entity @s data.gomoku.ai.root_sq set from entity @s data.gomoku.ai.top[$(index)].sq
        $data modify entity @s data.gomoku.ai.root_score set from entity @s data.gomoku.ai.top[$(index)].score
    ''')
    put('reply_done','''
        execute store result score #reply gm_ctx run data get entity @s data.gomoku.ai.reply
        execute store result score #value gm_ctx run data get entity @s data.gomoku.ai.root_score
        scoreboard players set #two gm_ctx 2
        scoreboard players operation #reply gm_ctx *= #two gm_ctx
        scoreboard players operation #value gm_ctx -= #reply gm_ctx
        execute store result score #best gm_ctx run data get entity @s data.gomoku.ai.best
        execute if score #value gm_ctx > #best gm_ctx run function gomoku:ai/better_reply
        execute store result score #root gm_ctx run data get entity @s data.gomoku.ai.root
        scoreboard players add #root gm_ctx 1
        execute store result entity @s data.gomoku.ai.root int 1 run scoreboard players get #root gm_ctx
        execute if score #root gm_ctx matches 3.. run return run function gomoku:ai/submit
        function gomoku:ai/prepare_reply
    ''')
    put('better_reply','''
        execute store result entity @s data.gomoku.ai.best int 1 run scoreboard players get #value gm_ctx
        data modify entity @s data.gomoku.ai.chosen set from entity @s data.gomoku.ai.root_sq
    ''')
    put('submit','''
        scoreboard players set @s gm_aistate 0
        execute unless score @s gm_aiepoch = @s gm_epoch run return 0
        execute unless score @s gm_turn = @s gm_bot run return 0
        function gomoku:game/snapshot
        execute store result score #to gm_ctx run data get entity @s data.gomoku.ai.chosen
        function gomoku:engine/try_move
        data remove entity @s data.gomoku.ai
    ''')
    put('full','''
        scoreboard players set @s gm_aistate 0
        function gomoku:engine/evaluate
        execute if score @s gm_result matches 0 run function gomoku:engine/invalid
        function gomoku:game/finish
    ''')
    put('invalid','''
        function gomoku:ai/reset
        function gomoku:engine/invalid
        function gomoku:game/finish
    ''')
    put('shape_score','''
        scoreboard players set #part gm_ctx 0
        execute if score #length gm_ctx matches 1 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 10
        execute if score #length gm_ctx matches 2 if score #open gm_ctx matches 1 run scoreboard players set #part gm_ctx 80
        execute if score #length gm_ctx matches 2 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 400
        execute if score #length gm_ctx matches 3 if score #open gm_ctx matches 1 run scoreboard players set #part gm_ctx 1200
        execute if score #length gm_ctx matches 3 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 12000
        execute if score #length gm_ctx matches 4 if score #open gm_ctx matches 1 run scoreboard players set #part gm_ctx 20000
        execute if score #length gm_ctx matches 4 if score #open gm_ctx matches 2 run scoreboard players set #part gm_ctx 100000
        execute if score #length gm_ctx matches 5.. run scoreboard players set #part gm_ctx 100000000
        execute if score #length gm_ctx matches 4 if score #open gm_ctx matches 1.. run scoreboard players add #fork gm_ctx 1
        execute if score #length gm_ctx matches 3 if score #open gm_ctx matches 2 run scoreboard players add #fork gm_ctx 1
        scoreboard players operation #shape gm_ctx += #part gm_ctx
    ''')
    for i in range(361):
        f,r=i%19,i//19
        neighbors=[rr*19+ff for rr in range(max(0,r-2),min(18,r+2)+1) for ff in range(max(0,f-2),min(18,f+2)+1) if (ff,rr)!=(f,r)]
        shape=['scoreboard players set #shape gm_ctx 0','scoreboard players set #fork gm_ctx 0']
        for df,dr in DIRECTIONS:
            shape += ['scoreboard players set #length gm_ctx 1','scoreboard players set #open gm_ctx 0']
            for sign in (-1,1):
                shape.append('scoreboard players set #run gm_ctx 1')
                for d in range(1,5):
                    tf,tr=f+df*d*sign,r+dr*d*sign
                    if not(0<=tf<19 and 0<=tr<19): break
                    dest=tr*19+tf
                    shape += [f'execute if score #run gm_ctx matches 1 if score #b{dest} gm_ctx = #stone gm_ctx run scoreboard players add #length gm_ctx 1',f'execute if score #run gm_ctx matches 1 if score #b{dest} gm_ctx matches 0 run scoreboard players add #open gm_ctx 1',f'execute unless score #b{dest} gm_ctx = #stone gm_ctx run scoreboard players set #run gm_ctx 0']
            shape.append('function gomoku:ai/shape_score')
        put(f'shape/{i}', '\n'.join(shape))
        cell=[f'execute unless score #b{i} gm_ctx matches 0 run return 0','scoreboard players set #neighbor gm_ctx 0']
        cell += [f'execute if score #b{dest} gm_ctx matches -1 run scoreboard players set #neighbor gm_ctx 1\nexecute if score #b{dest} gm_ctx matches 1 run scoreboard players set #neighbor gm_ctx 1' for dest in neighbors]
        cell += ['execute unless score #neighbor gm_ctx matches 1 run return 0',f'scoreboard players set #candidate gm_ctx {i}',f'execute if score #stage gm_ctx matches 2 run return run function gomoku:ai/reply/{i}',f'function gomoku:ai/score/{i}','function gomoku:ai/consider']
        put(f'cell/{i}', '\n'.join(cell))
        # Mandatory one-move wins/blocks are shared by all levels; easy differs in
        # the remaining choice, normal balances contiguous shapes, hard adds forks.
        put(f'score/{i}',f'''
            scoreboard players operation #stone gm_ctx = #side gm_ctx
            function gomoku:ai/shape/{i}
            scoreboard players operation #own gm_ctx = #shape gm_ctx
            scoreboard players operation #ownfork gm_ctx = #fork gm_ctx
            scoreboard players operation #stone gm_ctx *= #minus gm_ctx
            function gomoku:ai/shape/{i}
            scoreboard players operation #enemy gm_ctx = #shape gm_ctx
            execute store result score #random gm_ctx run random value 0..100
            scoreboard players operation #score gm_ctx = #random gm_ctx
            execute if score @s gm_level matches 2.. run function gomoku:ai/strategic
            execute if score #enemy gm_ctx matches 100000000.. run scoreboard players set #score gm_ctx 10000000
            execute if score #own gm_ctx matches 100000000.. run scoreboard players set #score gm_ctx 100000000
        ''')
        put(f'reply/{i}',f'''
            scoreboard players operation #stone gm_ctx = #side gm_ctx
            scoreboard players operation #stone gm_ctx *= #minus gm_ctx
            function gomoku:ai/shape/{i}
            execute if score #fork gm_ctx matches 2.. run scoreboard players add #shape gm_ctx 200000
            execute store result score #reply gm_ctx run data get entity @s data.gomoku.ai.reply
            execute if score #shape gm_ctx > #reply gm_ctx store result entity @s data.gomoku.ai.reply int 1 run scoreboard players get #shape gm_ctx
        ''')
    put('strategic','''
        scoreboard players operation #score gm_ctx = #own gm_ctx
        scoreboard players operation #score gm_ctx += #own gm_ctx
        scoreboard players operation #score gm_ctx += #enemy gm_ctx
        scoreboard players operation #score gm_ctx += #random gm_ctx
        execute if score @s gm_level matches 3 if score #ownfork gm_ctx matches 2.. run scoreboard players add #score gm_ctx 200000
        execute if score @s gm_level matches 3 if score #fork gm_ctx matches 2.. run scoreboard players add #score gm_ctx 150000
    ''')


if __name__=='__main__':
    build()
