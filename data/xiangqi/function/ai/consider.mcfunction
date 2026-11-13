data modify entity @s data.xiangqi.ai.candidate set value {f:0,t:0,score:0}
execute store result entity @s data.xiangqi.ai.candidate.f int 1 run scoreboard players get #from xq_ctx
execute store result entity @s data.xiangqi.ai.candidate.t int 1 run scoreboard players get #to xq_ctx
execute store result entity @s data.xiangqi.ai.candidate.score int 1 run scoreboard players get #ai_score xq_ctx
execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.best[0].score
execute if score #ai_score xq_ctx > #ai_best xq_ctx run return run function xiangqi:ai/insert0
execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.best[1].score
execute if score #ai_score xq_ctx > #ai_best xq_ctx run return run function xiangqi:ai/insert1
execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.best[2].score
execute if score #ai_score xq_ctx > #ai_best xq_ctx run return run function xiangqi:ai/insert2
execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.best[3].score
execute if score #ai_score xq_ctx > #ai_best xq_ctx run return run function xiangqi:ai/insert3
