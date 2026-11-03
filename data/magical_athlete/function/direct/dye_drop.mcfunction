scoreboard players set @s ma_dye 0
tag @a[tag=ma.dye_owner] remove ma.dye_owner
tag @s add ma.dye_owner
execute as @e[type=minecraft:item,distance=..6] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/dye_check
tag @s remove ma.dye_owner
