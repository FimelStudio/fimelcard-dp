# 牌盒生成后至少等待一个完整游戏刻再开始插值，确保客户端先收到0.1倍的初始大小
scoreboard players add @s fc_timer 1
execute if score @s fc_timer matches 2 run function cardtable:animation/deal/box/grow

# 10刻放大动画结束后进入逐张发牌阶段
execute if score @s fc_timer matches 13.. run function fast_card:deal/begin_cards
