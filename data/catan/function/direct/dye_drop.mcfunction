scoreboard players set @s ca_dye 0
tag @a[tag=ca.dye_owner] remove ca.dye_owner
tag @s add ca.dye_owner
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{catan:{tool:1b}}] run function catan:direct/dye_check
tag @s remove ca.dye_owner
