execute store result score #root gm_ctx run data get entity @s data.gomoku.ai.root
execute store result storage gomoku:ctx root.index int 1 run scoreboard players get #root gm_ctx
function gomoku:ai/select_root with storage gomoku:ctx root
data modify entity @s data.gomoku.ai.index set value 0
data modify entity @s data.gomoku.ai.reply set value 0
