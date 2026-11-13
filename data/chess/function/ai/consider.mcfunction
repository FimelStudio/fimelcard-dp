data modify entity @s data.chess.ai.candidate set value {f:0,t:0,score:0}
execute store result entity @s data.chess.ai.candidate.f int 1 run scoreboard players get #from ch_ctx
execute store result entity @s data.chess.ai.candidate.t int 1 run scoreboard players get #to ch_ctx
execute store result entity @s data.chess.ai.candidate.score int 1 run scoreboard players get #ai_score ch_ctx
execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.best[0].score
execute if score #ai_score ch_ctx > #ai_best ch_ctx run return run function chess:ai/insert0
execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.best[1].score
execute if score #ai_score ch_ctx > #ai_best ch_ctx run return run function chess:ai/insert1
execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.best[2].score
execute if score #ai_score ch_ctx > #ai_best ch_ctx run return run function chess:ai/insert2
execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.best[3].score
execute if score #ai_score ch_ctx > #ai_best ch_ctx run return run function chess:ai/insert3
