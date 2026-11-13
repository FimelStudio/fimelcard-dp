execute unless score #left ll_ctx matches 1.. run return 0
scoreboard players operation #upper ll_ctx = #left ll_ctx
scoreboard players remove #upper ll_ctx 1
execute store result storage love_letter:runtime rng.upper int 1 run scoreboard players get #upper ll_ctx
function love_letter:engine/random_index with storage love_letter:runtime rng
execute store result storage love_letter:runtime rng.index int 1 run scoreboard players get #index ll_ctx
function love_letter:engine/shuffle_take with storage love_letter:runtime rng
scoreboard players remove #left ll_ctx 1
execute if score #left ll_ctx matches 1.. run function love_letter:engine/shuffle
