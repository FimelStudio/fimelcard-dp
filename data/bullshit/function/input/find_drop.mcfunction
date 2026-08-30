tag @e[tag=bw.drop] remove bw.drop
$execute as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:paper[minecraft:custom_data~{bullshit:{card:1b,table:$(table)}}] run tag @s add bw.drop
