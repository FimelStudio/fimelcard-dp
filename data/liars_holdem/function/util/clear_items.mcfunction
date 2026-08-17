# 只清理由本游戏custom_data标识的手牌和操作物品
clear @s minecraft:paper[minecraft:custom_data~{liars_holdem:{card:1b}}]
clear @s minecraft:lime_dye[minecraft:custom_data~{liars_holdem:{action:"call"}}]
clear @s minecraft:red_dye[minecraft:custom_data~{liars_holdem:{action:"fold"}}]
