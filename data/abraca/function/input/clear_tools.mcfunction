# 仅回收本游戏的操作牌及旧版实体牌背，不触碰其他物品。
clear @s minecraft:paper[minecraft:custom_data~{abraca:{cast:1b}}]
clear @s minecraft:black_dye[minecraft:custom_data~{abraca:{cast:1b}}]
clear @s minecraft:paper[minecraft:custom_data~{abraca:{stone:1b}}]
scoreboard players reset @s ab_input
