execute store result score #ai_seen ch_ctx run data get entity @s data.chess.ai.seen
scoreboard players add #ai_seen ch_ctx 1
execute store result entity @s data.chess.ai.seen int 1 run scoreboard players get #ai_seen ch_ctx
execute store result score #ai_random ch_ctx run random value 0..2147483647
scoreboard players operation #ai_random ch_ctx %= #ai_seen ch_ctx
execute unless score #ai_random ch_ctx matches 0 run return 0
data modify entity @s data.chess.ai.best[0] set value {f:0,t:0,score:0}
execute store result entity @s data.chess.ai.best[0].f int 1 run scoreboard players get #from ch_ctx
execute store result entity @s data.chess.ai.best[0].t int 1 run scoreboard players get #to ch_ctx
