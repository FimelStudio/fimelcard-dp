scoreboard players set @s ch_drop 0
tag @a[tag=ch.dropper] remove ch.dropper
tag @s add ch.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}] run function chess:input/check_drop
tag @s remove ch.dropper
