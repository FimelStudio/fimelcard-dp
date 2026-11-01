tag @s add go.controller
execute unless score @s go_board matches 0..1 run scoreboard players set @s go_board 0
execute unless score @s go_orient matches 0..1 run scoreboard players set @s go_orient 0
execute unless score @s go_time matches 0..30 run scoreboard players set @s go_time 10
execute unless score @s go_first matches 0..1 run scoreboard players set @s go_first 1
execute unless score @s go_level matches 1..3 run scoreboard players set @s go_level 2
execute unless score @s go_mark matches 0..1 run scoreboard players set @s go_mark 1
execute unless score @s go_coords matches 0..1 run scoreboard players set @s go_coords 1
execute unless score @s go_confirm matches 0..1 run scoreboard players set @s go_confirm 0
execute unless score @s go_estimate matches 0..1 run scoreboard players set @s go_estimate 1
execute unless score @s go_komi matches -40..40 run scoreboard players set @s go_komi 15
execute unless score @s go_epoch matches 1.. run scoreboard players set @s go_epoch 1
execute unless score @s go_size matches 13 unless score @s go_size matches 15 unless score @s go_size matches 19 run scoreboard players set @s go_size 19
