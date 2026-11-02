# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage uno:ui grid.extra append value {text:"",click_event:{action:"run_command",command:"trigger un_action set $(pick)"},hover_event:{action:"show_text",value:{text:"$(name) ×$(count) · $(pick_hint)"}},extra:[{text:"$(glyph)",font:"$(card_font)",color:"white"},{text:"×$(count)  ",font:"minecraft:default",color:"white"}]}
