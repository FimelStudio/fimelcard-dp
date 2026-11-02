# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute store result score #item_count ac_ctx run clear @s *[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:1,table:$(table)}}] 0
$execute if score #item_count ac_ctx matches 0 run function aeroplane_chess:input/place {table:$(table),slot:0,action:1,name:"飞行棋 · 投骰",model:"card:aeroplane_chess/dice"}
