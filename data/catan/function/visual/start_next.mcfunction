execute unless data entity @s data.catan.visual_events[0] run return 0
function catan:visual/context
data modify entity @s data.catan.visual_active set from entity @s data.catan.visual_events[0]
data remove entity @s data.catan.visual_events[0]
execute unless data entity @s data.catan.visual_active.owner run data modify entity @s data.catan.visual_active.owner set from entity @s data.catan.visual_active.actor
execute unless data entity @s data.catan.visual_active.target run data modify entity @s data.catan.visual_active.target set from entity @s data.catan.visual_active.a
data modify storage catan:visual event set from entity @s data.catan.visual_active
scoreboard players set @s ca_vkind 0
scoreboard players set @s ca_vtimer 0
execute if data storage catan:visual event{kind:"road"} run scoreboard players set @s ca_vkind 1
execute if data storage catan:visual event{kind:"settlement"} run scoreboard players set @s ca_vkind 2
execute if data storage catan:visual event{kind:"city"} run scoreboard players set @s ca_vkind 3
execute if data storage catan:visual event{kind:"robber"} run scoreboard players set @s ca_vkind 4
execute if data storage catan:visual event{kind:"dice"} run scoreboard players set @s ca_vkind 5
execute if data storage catan:visual event{kind:"trade"} run scoreboard players set @s ca_vkind 6
execute if data storage catan:visual event{kind:"production"} run scoreboard players set @s ca_vkind 7
execute if data storage catan:visual event{kind:"development"} run scoreboard players set @s ca_vkind 8
execute if data storage catan:visual event{kind:"win"} run scoreboard players set @s ca_vkind 9
execute if score @s ca_vkind matches 1..4 run scoreboard players set @s ca_vtimer 8
execute if score @s ca_vkind matches 5 run scoreboard players set @s ca_vtimer 20
execute if score @s ca_vkind matches 6..8 run scoreboard players set @s ca_vtimer 2
execute if score @s ca_vkind matches 9 run scoreboard players set @s ca_vtimer 12
execute at @s if score @s ca_vkind matches 1..3 run function catan:visual/build_tick
execute at @s if score @s ca_vkind matches 4 run function catan:visual/robber_start
execute at @s if score @s ca_vkind matches 5 run function catan:visual/dice_start
execute at @s if score @s ca_vkind matches 6 run function catan:visual/trade
execute at @s if score @s ca_vkind matches 7 run function catan:visual/production
execute at @s if score @s ca_vkind matches 8 run function catan:visual/development
execute at @s if score @s ca_vkind matches 9 run function catan:visual/win
