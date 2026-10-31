scoreboard players set @s xq_drop 0
tag @a[tag=xq.dropper] remove xq.dropper
tag @s add xq.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}] run function xiangqi:input/check_drop
tag @s remove xq.dropper
