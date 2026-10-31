scoreboard players operation #cap gm_ctx = @s ct_capacity
scoreboard players operation #orient gm_ctx = @s gm_orient
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 run scoreboard players set #black_seat gm_ctx 3
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 run scoreboard players set #black_last gm_ctx 3
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 run scoreboard players set #white_seat gm_ctx 1
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 0 run scoreboard players set #white_last gm_ctx 1
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 run scoreboard players set #black_seat gm_ctx 4
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 run scoreboard players set #black_last gm_ctx 4
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 run scoreboard players set #white_seat gm_ctx 2
execute if score #cap gm_ctx matches 4 if score #orient gm_ctx matches 1 run scoreboard players set #white_last gm_ctx 2
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 run scoreboard players set #black_seat gm_ctx 5
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 run scoreboard players set #black_last gm_ctx 6
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 run scoreboard players set #white_seat gm_ctx 1
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 0 run scoreboard players set #white_last gm_ctx 2
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 run scoreboard players set #black_seat gm_ctx 7
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 run scoreboard players set #black_last gm_ctx 8
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 run scoreboard players set #white_seat gm_ctx 3
execute if score #cap gm_ctx matches 8 if score #orient gm_ctx matches 1 run scoreboard players set #white_last gm_ctx 4
