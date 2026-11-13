# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage skull:ui dialog.actions append value {label:{text:"$(label)"},action:{type:"minecraft:run_command",command:"trigger sk_action set $(value)"}}
