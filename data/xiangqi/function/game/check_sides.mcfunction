scoreboard players set #side_ok xq_ctx 0
execute if score @s ct_joined matches 2 if score #red_ready xq_ctx matches 1 if score #black_ready xq_ctx matches 1 run scoreboard players set #side_ok xq_ctx 1
execute if score @s ct_joined matches 1 if score #red_ready xq_ctx matches 1 run scoreboard players set #side_ok xq_ctx 1
execute if score @s ct_joined matches 1 if score #black_ready xq_ctx matches 1 run scoreboard players set #side_ok xq_ctx 1
