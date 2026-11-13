# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tellraw @s {text:"[胡闹运动会] 局面或窗口已更新，请重新选择。",color:"gray"}
function magical_athlete:ui/open
