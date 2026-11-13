# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if entity @e[tag=gd.current,scores={gd_phase=1},limit=1] if entity @e[tag=gd.me,scores={gd_tribute=1},limit=1] run function guandan:ui/button {code:23,label:"确定贡牌",color:"green"}
execute if entity @e[tag=gd.current,scores={gd_phase=2},limit=1] if entity @e[tag=gd.me,scores={gd_return=1},limit=1] run function guandan:ui/button {code:23,label:"确定还牌",color:"green"}
