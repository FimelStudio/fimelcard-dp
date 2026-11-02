# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
function guandan:ui/button {code:20,label:"出牌",color:"green"}
execute unless score @e[tag=gd.current,limit=1] gd_lastkind matches 0 run function guandan:ui/button {code:21,label:"不出",color:"yellow"}
