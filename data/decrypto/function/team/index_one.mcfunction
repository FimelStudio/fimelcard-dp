execute if score @s dc_team matches 1 run scoreboard players operation @s dc_index = #white_count dc_ctx
execute if score @s dc_team matches 1 run scoreboard players add #white_count dc_ctx 1
execute if score @s dc_team matches 2 run scoreboard players operation @s dc_index = #black_count dc_ctx
execute if score @s dc_team matches 2 run scoreboard players add #black_count dc_ctx 1
