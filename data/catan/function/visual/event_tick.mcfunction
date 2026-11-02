scoreboard players remove @s ca_vtimer 1
data modify storage catan:visual event set from entity @s data.catan.visual_active
execute if score @s ca_vkind matches 1..3 run function catan:visual/build_tick
execute if score @s ca_vkind matches 4 run function catan:visual/robber_tick
execute if score @s ca_vkind matches 5 run function catan:visual/dice_tick
execute if score @s ca_vkind matches 9 run function catan:visual/win
execute unless score @s ca_vtimer matches 1.. run scoreboard players set @s ca_vkind 0
