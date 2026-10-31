execute store result score #choice gm_ctx run data get entity @s data.gomoku.ai.top[0].sq
execute store result score #value gm_ctx run data get entity @s data.gomoku.ai.top[0].score
execute unless score #choice gm_ctx matches 0..360 run return run function gomoku:ai/full
execute store result entity @s data.gomoku.ai.chosen int 1 run scoreboard players get #choice gm_ctx
execute unless score @s gm_level matches 3 run return run function gomoku:ai/submit
execute if score #value gm_ctx matches 100000000.. run return run function gomoku:ai/submit
data modify entity @s data.gomoku.ai.stage set value 2
data modify entity @s data.gomoku.ai.root set value 0
function gomoku:ai/prepare_reply
