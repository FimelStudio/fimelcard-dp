# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,table:$(table),seat:$(seat)}}] run function hanabi:input/tag_drop
