execute unless score #index gm_ctx matches 0..360 run return 0
execute store result storage gomoku:ctx ai.sq int 1 run scoreboard players get #index gm_ctx
function gomoku:ai/dispatch with storage gomoku:ctx ai
scoreboard players add #index gm_ctx 1
scoreboard players remove #work gm_ctx 1
execute if score #work gm_ctx matches 1.. if score #index gm_ctx matches ..360 run function gomoku:ai/batch
