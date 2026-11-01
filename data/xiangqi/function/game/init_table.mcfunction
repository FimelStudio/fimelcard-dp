tag @s add xq.controller
execute unless data entity @s data.xiangqi{palette_version:2b} run function xiangqi:system/migrate_palette
execute unless score @s xq_board matches 0..1 run scoreboard players set @s xq_board 0
execute unless score @s xq_palette matches 0..1 run scoreboard players set @s xq_palette 0
execute unless score @s xq_orient matches 0..1 run scoreboard players set @s xq_orient 0
execute unless score @s xq_time matches 0..30 run scoreboard players set @s xq_time 10
execute unless score @s xq_first matches 0..1 run scoreboard players set @s xq_first 1
execute unless score @s xq_level matches 1..3 run scoreboard players set @s xq_level 2
execute unless score @s xq_hints matches 0..1 run scoreboard players set @s xq_hints 1
execute unless score @s xq_bot matches -1..1 run scoreboard players set @s xq_bot 0
execute unless score @s xq_epoch matches 1.. run scoreboard players set @s xq_epoch 1
execute if score @s ct_state matches 0 run function xiangqi:game/preview
