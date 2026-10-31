tag @s add ch.controller
execute unless score @s ch_board matches 0..4 run scoreboard players set @s ch_board 0
execute unless score @s ch_palette matches 0..3 run scoreboard players set @s ch_palette 0
execute unless score @s ch_orient matches 0..1 run scoreboard players set @s ch_orient 0
execute unless score @s ch_time matches 0..30 run scoreboard players set @s ch_time 10
execute unless score @s ch_first matches 0..1 run scoreboard players set @s ch_first 0
execute unless score @s ch_level matches 1..3 run scoreboard players set @s ch_level 2
execute unless score @s ch_hints matches 0..1 run scoreboard players set @s ch_hints 1
execute unless score @s ch_bot matches -1..1 run scoreboard players set @s ch_bot 0
execute unless score @s ch_epoch matches 1.. run scoreboard players set @s ch_epoch 1
execute if score @s ct_state matches 0 run function chess:game/preview
