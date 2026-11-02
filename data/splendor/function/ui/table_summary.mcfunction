# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui public set value {text:"",extra:[{text:"第$(round)轮 · 当前：",color:"gold"}]}
$data modify storage splendor:ui public.extra append from entity @s data.splendor.p$(turn).name
execute if score @s sp_state matches 2 run data modify storage splendor:ui public.extra append value {text:" · 请退回超限筹码",color:"red"}
execute if score @s sp_state matches 3 run data modify storage splendor:ui public.extra append value {text:" · 请选择一位贵族",color:"yellow"}
execute if data entity @s data.splendor{final_round:1} run data modify storage splendor:ui public.extra append value {text:" · 最后一轮",color:"light_purple"}
