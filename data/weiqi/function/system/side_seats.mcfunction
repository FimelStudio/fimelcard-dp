scoreboard players operation #cap go_ctx = @s ct_capacity
scoreboard players operation #orient go_ctx = @s go_orient
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 0 run scoreboard players set #black_seat go_ctx 3
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 0 run scoreboard players set #black_last go_ctx 3
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 0 run scoreboard players set #white_seat go_ctx 1
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 0 run scoreboard players set #white_last go_ctx 1
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 1 run scoreboard players set #black_seat go_ctx 4
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 1 run scoreboard players set #black_last go_ctx 4
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 1 run scoreboard players set #white_seat go_ctx 2
execute if score #cap go_ctx matches 4 if score #orient go_ctx matches 1 run scoreboard players set #white_last go_ctx 2
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 0 run scoreboard players set #black_seat go_ctx 5
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 0 run scoreboard players set #black_last go_ctx 6
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 0 run scoreboard players set #white_seat go_ctx 1
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 0 run scoreboard players set #white_last go_ctx 2
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 1 run scoreboard players set #black_seat go_ctx 7
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 1 run scoreboard players set #black_last go_ctx 8
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 1 run scoreboard players set #white_seat go_ctx 3
execute if score #cap go_ctx matches 8 if score #orient go_ctx matches 1 run scoreboard players set #white_last go_ctx 4
