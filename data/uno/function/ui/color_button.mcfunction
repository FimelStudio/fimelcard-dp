# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result storage uno:ui code int 1 run scoreboard players get #ui_colorcode un_ctx
$data modify storage uno:ui label set value "$(name)"
$data modify storage uno:ui control_color set value "$(color)"
function uno:ui/color_append with storage uno:ui
