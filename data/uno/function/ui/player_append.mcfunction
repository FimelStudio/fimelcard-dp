# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage uno:ui players.extra append value {text:"",extra:[{text:"$(line_seat)号位 ",color:"gray"},$(line_name),{text:" · $(line_count)张 · $(line_score)分$(line_turn)\n",color:"gray"}]}
