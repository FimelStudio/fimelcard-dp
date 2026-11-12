scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 1 run scoreboard players set #chair_min ct_ctx 4
execute if score @s ct_game matches 2 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 3 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 4 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 5 run scoreboard players set #chair_min ct_ctx 3
execute if score @s ct_game matches 6 run scoreboard players set #chair_min ct_ctx 3
execute if score @s ct_game matches 7 run scoreboard players set #chair_min ct_ctx 3
execute if score @s ct_game matches 8 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 9 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 10 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 11 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 12 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 13 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 14 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 15 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 16 run scoreboard players set #chair_min ct_ctx 5
execute if score @s ct_game matches 17 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 18 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 19 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 20 run scoreboard players set #chair_min ct_ctx 1
execute if score @s ct_game matches 21 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 22 run scoreboard players set #chair_min ct_ctx 2
execute if score @s ct_game matches 23 run scoreboard players set #chair_min ct_ctx 2
# 飞行棋关闭电脑补位时须给至少两名真人留座。
execute if score @s ct_game matches 15 if score @s ac_fill matches 2 run scoreboard players set #chair_min ct_ctx 2
