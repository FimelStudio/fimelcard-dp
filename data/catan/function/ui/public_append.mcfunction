# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui public.extra append value {text:"",extra:[{text:"$(side)号（$(color_label)）· ",color:"$(color)"},$(name),{text:" · $(public_vp)分 · $(resource_count)资源 · $(dev_count)开发牌\n",color:"gray"}]}
