scoreboard players set @s go_drop 0
tag @a[tag=go.dropper] remove go.dropper
tag @s add go.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}] run function weiqi:input/check_drop
tag @s remove go.dropper
