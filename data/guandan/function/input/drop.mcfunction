scoreboard players set @s gd_drop 0
tag @a[tag=gd.dropper] remove gd.dropper
tag @s add gd.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents *[minecraft:custom_data~{guandan:{tool:1b}}] run function guandan:input/check_drop
tag @a[tag=gd.dropper] remove gd.dropper
