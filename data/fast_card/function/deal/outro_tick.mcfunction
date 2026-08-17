# 等待10刻缩小插值完成，再清除牌盒并正式进入传牌阶段
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 12.. run function cardtable:animation/deal/box/clear
execute if score @s fc_timer matches 12.. run function fast_card:deal/complete
