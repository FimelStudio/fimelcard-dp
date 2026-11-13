function catan:visual/init with storage catan:visual
scoreboard players set @s ca_vlife 8
data modify entity @s item.components."minecraft:custom_data" set value {catan_fx:{}}
data modify entity @s item.components."minecraft:custom_data".catan_fx set from storage catan:visual motion
