# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage guandan:ui option_button set value {label:{text:"$(option_label)",color:"$(option_color)"},width:220}
execute if data storage guandan:ui option{beat:1} run function guandan:ui/option_command with storage guandan:ui
data modify storage guandan:ui buttons append from storage guandan:ui option_button
