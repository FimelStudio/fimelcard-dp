# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function catan:hud/notice {"text":{"text":"没有瞄准可识别的地块、交点或道路中段，请重新瞄准。","color":"red"}}
