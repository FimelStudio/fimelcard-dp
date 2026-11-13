# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ca_side matches 1 run data modify storage catan:ui color_label set value "红"
execute if score @s ca_side matches 2 run data modify storage catan:ui color_label set value "蓝"
execute if score @s ca_side matches 3 run data modify storage catan:ui color_label set value "白"
execute if score @s ca_side matches 4 run data modify storage catan:ui color_label set value "橙"
