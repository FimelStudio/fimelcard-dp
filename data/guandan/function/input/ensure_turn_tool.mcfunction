# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute store result score #item_count gd_ctx run clear @s *[minecraft:custom_data~{guandan:{tool:1b,action:0,table:$(table)}}] 0
$execute if score #item_count gd_ctx matches 0 run function guandan:input/place_tool {table:$(table),slot:0,action:0,name:"掼蛋 · 手牌",model:"card:poker/back"}
