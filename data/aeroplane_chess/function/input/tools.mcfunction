# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute store result score #tools_have ac_ctx run clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:0,table:$(table)}}] 0
$execute if score #tools_have ac_ctx matches 0 run function aeroplane_chess:input/place {table:$(table),slot:8,action:0,name:"飞行棋 · 对局菜单",model:"minecraft:book"}
