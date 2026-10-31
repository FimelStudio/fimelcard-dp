# 只增加队列冷却目标，不重发真实手牌或重置旧牌局。
scoreboard objectives add un_anim_wait dummy
scoreboard players set #version un_ctx 2
