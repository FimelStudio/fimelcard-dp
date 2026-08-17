# 从本桌仍存在的牌堆中随机抽一张，把牌面编号复制到控制器后移除牌堆标记
tag @e[type=minecraft:marker,tag=fc.drawn_card,distance=..0.01] remove fc.drawn_card
execute as @e[type=minecraft:marker,tag=fc.deck,distance=..0.01,sort=random,limit=1] run tag @s add fc.drawn_card
execute unless entity @e[type=minecraft:marker,tag=fc.drawn_card,distance=..0.01,limit=1] run return fail
scoreboard players operation @s fc_card = @e[type=minecraft:marker,tag=fc.drawn_card,distance=..0.01,limit=1] fc_card
kill @e[type=minecraft:marker,tag=fc.drawn_card,distance=..0.01,limit=1]

# Fast Card只负责本张牌的内容，飞行动画和可靠送达交给通用牌桌模块
function fast_card:deal/give_card
