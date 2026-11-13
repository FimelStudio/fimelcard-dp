# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 等待10刻缩小插值完成，再清除牌盒并正式进入传牌阶段
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 12.. run function cardtable:animation/deal/box/clear
execute if score @s fc_timer matches 12.. run function fast_card:deal/complete
