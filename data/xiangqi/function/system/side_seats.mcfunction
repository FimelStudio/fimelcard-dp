scoreboard players operation #cap xq_ctx = @s ct_capacity
scoreboard players operation #orient xq_ctx = @s xq_orient
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 0 run scoreboard players set #red_seat xq_ctx 3
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 0 run scoreboard players set #red_last xq_ctx 3
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 0 run scoreboard players set #black_seat xq_ctx 1
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 0 run scoreboard players set #black_last xq_ctx 1
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 1 run scoreboard players set #red_seat xq_ctx 4
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 1 run scoreboard players set #red_last xq_ctx 4
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 1 run scoreboard players set #black_seat xq_ctx 2
execute if score #cap xq_ctx matches 4 if score #orient xq_ctx matches 1 run scoreboard players set #black_last xq_ctx 2
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 0 run scoreboard players set #red_seat xq_ctx 5
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 0 run scoreboard players set #red_last xq_ctx 6
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 0 run scoreboard players set #black_seat xq_ctx 1
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 0 run scoreboard players set #black_last xq_ctx 2
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 1 run scoreboard players set #red_seat xq_ctx 7
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 1 run scoreboard players set #red_last xq_ctx 8
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 1 run scoreboard players set #black_seat xq_ctx 3
execute if score #cap xq_ctx matches 8 if score #orient xq_ctx matches 1 run scoreboard players set #black_last xq_ctx 4
