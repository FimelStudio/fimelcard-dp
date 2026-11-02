# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui detail.extra append value {text:"",extra:[{text:"$(row_name)：",color:"gray"},{text:" [−] ",color:"aqua",click_event:{action:"run_command",command:"trigger sp_action set $(minus)"}},{text:"$(pick)",color:"gold",bold:true},{text:" [+] ",color:"aqua",click_event:{action:"run_command",command:"trigger sp_action set $(plus)"}},{text:"\n"}]}
