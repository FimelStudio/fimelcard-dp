# 控制器八个座位共同构成整场存活人数
scoreboard players set @s lh_alive_count 0
execute if score @s lh_a1 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a2 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a3 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a4 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a5 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a6 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a7 matches 1 run scoreboard players add @s lh_alive_count 1
execute if score @s lh_a8 matches 1 run scoreboard players add @s lh_alive_count 1
