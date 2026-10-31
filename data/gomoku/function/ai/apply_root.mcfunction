execute store result score #root_sq gm_ctx run data get entity @s data.gomoku.ai.root_sq
execute store result storage gomoku:ctx root.sq int 1 run scoreboard players get #root_sq gm_ctx
execute store result storage gomoku:ctx root.side int 1 run scoreboard players get #side gm_ctx
function gomoku:ai/root_overlay with storage gomoku:ctx root
