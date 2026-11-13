# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 牌盒生成后至少等待一个完整游戏刻再开始插值，确保客户端先收到0.1倍的初始大小
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 2 run function cardtable:animation/deal/box/grow

# 10刻放大动画结束后进入逐张发牌阶段
execute if score @s fc_timer matches 13.. run function fast_card:deal/begin_cards
