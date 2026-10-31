scoreboard players set @s gm_drop 0
tag @a[tag=gm.dropper] remove gm.dropper
tag @s add gm.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}] run function gomoku:input/check_drop
tag @s remove gm.dropper
