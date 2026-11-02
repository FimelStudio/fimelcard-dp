# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 4刻一张，共17张；只有处于发牌阶段的控制器会运行本函数
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 4.. run function fast_card:deal/step
