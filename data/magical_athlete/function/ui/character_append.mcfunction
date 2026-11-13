# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage magical_athlete:ui detail.extra append value {text:"",extra:[{text:"$(glyph)",font:"magical_athlete:icons",click_event:{action:"run_command",command:"trigger ma_action set $(command)"}},{text:" $(name) ",color:"aqua",bold:true,click_event:{action:"run_command",command:"trigger ma_action set $(command)"}},{text:"\n$(ability)\n\n\n",color:"gray"}]}
