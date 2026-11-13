scoreboard players set #side_ok ch_ctx 0
execute if score @s ct_joined matches 2 if score #white_ready ch_ctx matches 1 if score #black_ready ch_ctx matches 1 run scoreboard players set #side_ok ch_ctx 1
execute if score @s ct_joined matches 1 if score #white_ready ch_ctx matches 1 run scoreboard players set #side_ok ch_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready ch_ctx matches 1 run scoreboard players set #side_ok ch_ctx 1
