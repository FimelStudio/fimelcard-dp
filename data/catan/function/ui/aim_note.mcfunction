# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
dialog clear @s
tellraw @s {text:"[卡坦岛] 右键棋盘选择位置；也可瞄准后在第 1 格按 Q。",color:"aqua"}
