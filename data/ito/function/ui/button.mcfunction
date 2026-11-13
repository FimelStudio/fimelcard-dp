# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute store result storage ito:ui action int 1 run scoreboard players get #button it_ctx
function ito:ui/button_value with storage ito:ui
data modify storage ito:ui button.label.text set from storage ito:ui label
data modify storage ito:ui dialog.actions append from storage ito:ui button
