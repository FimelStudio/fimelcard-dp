scoreboard players set @s ac_drop 0
tag @a[tag=ac.dropper] remove ac.dropper
tag @s add ac.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}] run function aeroplane_chess:input/check_drop
tag @s remove ac.dropper
