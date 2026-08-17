scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run clear @s minecraft:lime_dye[minecraft:custom_data~{liars_holdem:{action:"call"}}]
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run clear @s minecraft:red_dye[minecraft:custom_data~{liars_holdem:{action:"fold"}}]
execute as @a[tag=lh.turn] if score @s lh_id = #ctx_id lh_ctx run tag @s remove lh.turn
