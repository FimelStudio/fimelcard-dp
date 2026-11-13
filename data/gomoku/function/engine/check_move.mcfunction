scoreboard players set #legal gm_ctx 0
execute unless score @s gm_size matches 13 unless score @s gm_size matches 15 unless score @s gm_size matches 19 run return 0
execute unless score @s gm_turn matches 1 unless score @s gm_turn matches -1 run return 0
execute unless score #to gm_ctx matches 0..360 run return 0
execute unless score @s gm_result matches 0 run return 0
scoreboard players set #nineteen gm_ctx 19
scoreboard players operation #file gm_ctx = #to gm_ctx
scoreboard players operation #rank gm_ctx = #to gm_ctx
scoreboard players operation #file gm_ctx %= #nineteen gm_ctx
scoreboard players operation #rank gm_ctx /= #nineteen gm_ctx
execute unless score #file gm_ctx < @s gm_size run return 0
execute unless score #rank gm_ctx < @s gm_size run return 0
execute store result storage gomoku:ctx check.sq int 1 run scoreboard players get #to gm_ctx
function gomoku:engine/check_cell with storage gomoku:ctx check
