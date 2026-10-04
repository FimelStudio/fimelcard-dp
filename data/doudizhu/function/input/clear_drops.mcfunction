$execute as @e[type=minecraft:item] if items entity @s contents minecraft:book[minecraft:custom_data~{doudizhu:{table:$(table)}}] run kill @s
$execute as @e[type=minecraft:item] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{doudizhu:{table:$(table)}}] run kill @s
