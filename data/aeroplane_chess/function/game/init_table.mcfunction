tag @s add ac.controller
execute unless score @s ac_takeoff matches 0..2 run scoreboard players set @s ac_takeoff 0
execute unless score @s ac_extra matches 0..1 run scoreboard players set @s ac_extra 1
execute unless score @s ac_triple matches 0..1 run scoreboard players set @s ac_triple 0
execute unless score @s ac_jump matches 0..1 run scoreboard players set @s ac_jump 1
execute unless score @s ac_fly matches 0..1 run scoreboard players set @s ac_fly 1
execute unless score @s ac_finish matches 0..1 run scoreboard players set @s ac_finish 0
execute unless score @s ac_palette matches 0..0 run scoreboard players set @s ac_palette 0
execute unless score @s ac_orient matches 0..1 run scoreboard players set @s ac_orient 0
execute unless score @s ac_first matches 0..4 run scoreboard players set @s ac_first 0
execute unless score @s ac_speed matches 0..1 run scoreboard players set @s ac_speed 0
execute unless score @s ac_hints matches 0..1 run scoreboard players set @s ac_hints 1
execute unless score @s ac_fill matches 0..2 run scoreboard players set @s ac_fill 0
execute unless score @s ac_ranking matches 0..1 run scoreboard players set @s ac_ranking 0
execute unless score @s ac_assign matches 0..1 run scoreboard players set @s ac_assign 0
execute unless score @s ac_epoch matches 1.. run scoreboard players set @s ac_epoch 1
execute if score @s ct_state matches 0 run function aeroplane_chess:game/preview
