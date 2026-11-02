# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:input/clear_surface
execute if score @s ct_capacity matches 4 positioned ~ ~1.025 ~ summon minecraft:interaction run function catan:input/surface {width:2.70f}
execute if score @s ct_capacity matches 8 positioned ~ ~1.025 ~ summon minecraft:interaction run function catan:input/surface {width:3.60f}
