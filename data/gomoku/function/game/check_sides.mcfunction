scoreboard players set #side_ok gm_ctx 0
execute if score @s ct_joined matches 2 if score #black_ready gm_ctx matches 1 if score #white_ready gm_ctx matches 1 run scoreboard players set #side_ok gm_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready gm_ctx matches 1 run scoreboard players set #side_ok gm_ctx 1
execute if score @s ct_joined matches 1 if score #white_ready gm_ctx matches 1 run scoreboard players set #side_ok gm_ctx 1
