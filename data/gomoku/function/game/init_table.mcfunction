tag @s add gm.controller
execute unless score @s gm_board matches 0..1 run scoreboard players set @s gm_board 0
scoreboard players set @s gm_palette 0
execute unless score @s gm_orient matches 0..1 run scoreboard players set @s gm_orient 0
execute unless score @s gm_time matches 0..30 run scoreboard players set @s gm_time 10
execute unless score @s gm_first matches 0..1 run scoreboard players set @s gm_first 0
execute unless score @s gm_level matches 1..3 run scoreboard players set @s gm_level 2
execute unless score @s gm_size matches 13 unless score @s gm_size matches 15 unless score @s gm_size matches 19 run scoreboard players set @s gm_size 15
execute unless score @s gm_mark matches 0..1 run scoreboard players set @s gm_mark 1
execute unless score @s gm_coords matches 0..1 run scoreboard players set @s gm_coords 1
execute unless score @s gm_confirm matches 0..1 run scoreboard players set @s gm_confirm 0
execute unless score @s gm_bot matches -1..1 run scoreboard players set @s gm_bot 0
execute unless score @s gm_epoch matches 1.. run scoreboard players set @s gm_epoch 1
execute if score @s ct_state matches 0 run function gomoku:game/preview
