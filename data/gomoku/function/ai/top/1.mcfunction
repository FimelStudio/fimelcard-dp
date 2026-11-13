data modify storage gomoku:ctx candidate set value {sq:0,score:0}
execute store result storage gomoku:ctx candidate.sq int 1 run scoreboard players get #candidate gm_ctx
execute store result storage gomoku:ctx candidate.score int 1 run scoreboard players get #score gm_ctx
data modify entity @s data.gomoku.ai.top insert 1 from storage gomoku:ctx candidate
data remove entity @s data.gomoku.ai.top[-1]
execute store result score #top0 gm_ctx run data get entity @s data.gomoku.ai.top[0].score
execute store result score #top1 gm_ctx run data get entity @s data.gomoku.ai.top[1].score
execute store result score #top2 gm_ctx run data get entity @s data.gomoku.ai.top[2].score
