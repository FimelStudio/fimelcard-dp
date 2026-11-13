# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @e[tag=bw.drop] remove bw.drop
$execute as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:lime_dye[minecraft:custom_data~{bullshit:{card:1b,table:$(table)}}] run tag @s add bw.drop
