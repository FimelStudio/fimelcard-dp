scoreboard players operation #cap ch_ctx = @s ct_capacity
scoreboard players operation #orient ch_ctx = @s ch_orient
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 0 run scoreboard players set #white_seat ch_ctx 3
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 0 run scoreboard players set #white_last ch_ctx 3
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 0 run scoreboard players set #black_seat ch_ctx 1
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 0 run scoreboard players set #black_last ch_ctx 1
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 1 run scoreboard players set #white_seat ch_ctx 4
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 1 run scoreboard players set #white_last ch_ctx 4
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 1 run scoreboard players set #black_seat ch_ctx 2
execute if score #cap ch_ctx matches 4 if score #orient ch_ctx matches 1 run scoreboard players set #black_last ch_ctx 2
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 0 run scoreboard players set #white_seat ch_ctx 5
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 0 run scoreboard players set #white_last ch_ctx 6
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 0 run scoreboard players set #black_seat ch_ctx 1
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 0 run scoreboard players set #black_last ch_ctx 2
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 1 run scoreboard players set #white_seat ch_ctx 7
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 1 run scoreboard players set #white_last ch_ctx 8
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 1 run scoreboard players set #black_seat ch_ctx 3
execute if score #cap ch_ctx matches 8 if score #orient ch_ctx matches 1 run scoreboard players set #black_last ch_ctx 4
