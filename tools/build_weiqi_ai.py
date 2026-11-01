"""围棋基础电脑：每 tick 只试算一着，避免满盘规则扫描挤在同一刻。

这是本地轻量规则策略，非围棋分析引擎。三档只改变候选数量和局部权重。
不依赖外部服务，也不读取真人隐藏状态（围棋全部棋子本来公开）。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1] / 'data/weiqi/function/ai'
OBJECTIVES = {n: 'dummy' for n in '''go_aistate go_aiwait go_aiepoch go_aibest go_aiscore
go_aiattempt go_aimoves go_tested go_aiweight'''.split()}


def put(name, lines):
    p=ROOT/(name+'.mcfunction'); p.parent.mkdir(parents=True,exist_ok=True)
    p.write_text(('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n',encoding='utf-8')


def main():
    put('reset', '''
scoreboard players set @s go_aistate 0
scoreboard players set @s go_aiwait 0
scoreboard players set @s go_aibest -1
scoreboard players set @s go_aiscore -1000000
scoreboard players set @s go_aiattempt 0
''')
    put('tick', '''
execute if score @s go_bot matches 0 run return 0
execute unless score @s go_turn = @s go_bot run return 0
execute unless score @s go_state matches 1 run return 0
execute if score @s go_aistate matches 0 run return run function weiqi:ai/start
execute unless score @s go_aiepoch = @s go_epoch run return run function weiqi:ai/reset
execute if score @s go_aistate matches 2 run return run function weiqi:ai/commit
scoreboard players add @s go_aiwait 1
execute if score @s go_aiwait matches ..10 run return 0
function weiqi:system/context
execute if score @s go_passes matches 1.. run return run function weiqi:ai/pass
function weiqi:ai/probe
''')
    put('start', '''
function weiqi:system/context
function weiqi:ai/reset
scoreboard players set @s go_aistate 1
scoreboard players operation @s go_aiepoch = @s go_epoch
scoreboard players set @e[tag=go.board] go_tested 0
scoreboard players set @s go_aimoves 14
execute if score @s go_level matches 2 run scoreboard players set @s go_aimoves 28
execute if score @s go_level matches 3 run scoreboard players set @s go_aimoves 48
''')
    put('probe', '''
tag @e[tag=go.ai_candidate] remove go.ai_candidate
tag @e[tag=go.board,scores={go_piece=0,go_tested=0},sort=random,limit=1] add go.ai_candidate
execute unless entity @e[tag=go.ai_candidate,limit=1] run return run function weiqi:ai/ready
scoreboard players set @e[tag=go.ai_candidate,limit=1] go_tested 1
scoreboard players operation #to go_ctx = @e[tag=go.ai_candidate,limit=1] go_sq
function weiqi:engine/check_move
execute if score #legal go_ctx matches 1 run function weiqi:ai/evaluate
scoreboard players add @s go_aiattempt 1
execute if score @s go_aiattempt >= @s go_aimoves run function weiqi:ai/ready
''')
    put('ready', 'scoreboard players set @s go_aistate 2')
    # 棋盘全公开：中央/三四路开发、提子、气和局部相连，避免纯随机自填眼。
    evaluate = '''
scoreboard players operation #ai_to go_ctx = #to go_ctx
scoreboard players operation #ai_score go_ctx = #captured go_ctx
scoreboard players set #ai_hundred go_ctx 100
scoreboard players operation #ai_score go_ctx *= #ai_hundred go_ctx
scoreboard players operation #ai_lib go_ctx = #liberties go_ctx
execute if score #ai_lib go_ctx matches 7.. run scoreboard players set #ai_lib go_ctx 6
scoreboard players operation #ai_score go_ctx += #ai_lib go_ctx
execute if score #liberties go_ctx matches 1 run scoreboard players remove #ai_score go_ctx 70
scoreboard players operation #ai_file go_ctx = @e[tag=go.ai_candidate,limit=1] go_file
scoreboard players operation #ai_rank go_ctx = @e[tag=go.ai_candidate,limit=1] go_rank
scoreboard players operation #ai_edge go_ctx = @s go_size
scoreboard players remove #ai_edge go_ctx 1
scoreboard players operation #ai_farfile go_ctx = #ai_edge go_ctx
scoreboard players operation #ai_farfile go_ctx -= #ai_file go_ctx
scoreboard players operation #ai_farrank go_ctx = #ai_edge go_ctx
scoreboard players operation #ai_farrank go_ctx -= #ai_rank go_ctx
scoreboard players operation #ai_dist go_ctx = #ai_file go_ctx
scoreboard players operation #ai_dist go_ctx < #ai_rank go_ctx
scoreboard players operation #ai_dist go_ctx < #ai_farfile go_ctx
scoreboard players operation #ai_dist go_ctx < #ai_farrank go_ctx
execute if score @s go_level matches 2.. if score #ai_dist go_ctx matches 2..3 run scoreboard players add #ai_score go_ctx 12
execute if score @s go_level matches 2.. if score #ai_dist go_ctx matches 0 run scoreboard players remove #ai_score go_ctx 9
scoreboard players set #ai_own go_ctx 0
scoreboard players set #ai_opp go_ctx 0
scoreboard players set #ai_empty go_ctx 0
execute store result storage weiqi:runtime ai.to int 1 run scoreboard players get #ai_to go_ctx
function weiqi:ai/neighbors with storage weiqi:runtime ai
execute if score @s go_level matches 2.. if score #ai_own go_ctx matches 1..2 run scoreboard players add #ai_score go_ctx 5
execute if score @s go_level matches 3 if score #ai_opp go_ctx matches 1.. run scoreboard players add #ai_score go_ctx 4
# 四周全是己方棋子/边界的点，在没有提子时通常是眼，不主动填。
execute if score @s go_level matches 2.. if score #ai_empty go_ctx matches 0 if score #ai_opp go_ctx matches 0 if score #captured go_ctx matches 0 run scoreboard players remove #ai_score go_ctx 300
execute store result score #ai_noise go_ctx run random value 0..5
scoreboard players operation #ai_score go_ctx += #ai_noise go_ctx
execute if score #ai_score go_ctx > @s go_aiscore run function weiqi:ai/store_best
'''
    put('evaluate',evaluate)
    # 宏按交点分派，避免每候选扫描全盘求邻居。
    put('neighbors', '$function weiqi:ai/neighbors/$(to)')
    for sq in range(361):
        f,r=sq%19,sq//19
        neighbors=[]
        for df,dr in ((-1,0),(1,0),(0,-1),(0,1)):
            ff,rr=f+df,r+dr
            if 0<=ff<19 and 0<=rr<19:
                target=f'@e[tag=go.board,scores={{go_sq={rr*19+ff}}},limit=1]'
                neighbors.extend([f'execute if score {target} go_piece = @s go_turn run scoreboard players add #ai_own go_ctx 1',f'execute if score {target} go_piece matches 0 run scoreboard players add #ai_empty go_ctx 1',f'execute if score {target} go_piece matches -1..1 unless score {target} go_piece matches 0 unless score {target} go_piece = @s go_turn run scoreboard players add #ai_opp go_ctx 1'])
        put(f'neighbors/{sq}',neighbors)
    put('store_best', '''
scoreboard players operation @s go_aibest = #ai_to go_ctx
scoreboard players operation @s go_aiscore = #ai_score go_ctx
''')
    put('commit', '''
function weiqi:system/context
execute unless score @s go_state matches 1 run return run function weiqi:ai/reset
execute unless score @s go_turn = @s go_bot run return run function weiqi:ai/reset
execute unless score @s go_aiepoch = @s go_epoch run return run function weiqi:ai/reset
execute if score @s go_aibest matches ..-1 run return run function weiqi:ai/pass
execute if score @s go_aiscore matches ..-100 run return run function weiqi:ai/pass
scoreboard players operation #to go_ctx = @s go_aibest
function weiqi:engine/try_move
execute unless score #legal go_ctx matches 1 run return run function weiqi:ai/pass
function weiqi:game/after_move
''')
    put('pass', ['function weiqi:ai/reset', 'function weiqi:game/pass_internal'])
    print('Generated weiqi basic AI; one candidate trial per tick.')


if __name__=='__main__':
    main()
