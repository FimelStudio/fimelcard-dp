$execute as @e[type=minecraft:item,distance=..8] if items entity @s contents minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,table:$(table)}}] run kill @s
$execute as @e[type=minecraft:item,distance=..8] if items entity @s contents minecraft:firework_star[minecraft:custom_data~{hanabi:{action:"hint",table:$(table)}}] run kill @s
