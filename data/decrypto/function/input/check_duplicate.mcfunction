tag @e[tag=dc.duplicate] remove dc.duplicate
$execute as @e[type=minecraft:item_display,tag=dc.history] if items entity @s contents minecraft:paper[minecraft:custom_name=$(name)] run tag @s add dc.duplicate
