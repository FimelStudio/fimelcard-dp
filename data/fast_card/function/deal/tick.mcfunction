# 4刻一张，共17张；只有处于发牌阶段的控制器会运行本函数
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 4.. run function fast_card:deal/step
