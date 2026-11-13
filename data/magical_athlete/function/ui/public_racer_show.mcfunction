# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui detail.extra append value {text:"",extra:[{text:"$(name) · 第$(pos)格 · $(state_label)$(trip_label) · ",color:"aqua"},$(owner_name),{text:"\n固有能力：$(ability)\n\n",color:"gray"}]}
