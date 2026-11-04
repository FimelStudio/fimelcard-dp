scoreboard players set @s sp_dye 0
tag @a[tag=sp.dye_owner] remove sp.dye_owner
tag @s add sp.dye_owner
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{splendor:{tool:1b}}] run function splendor:direct/dye_check
tag @s remove sp.dye_owner
