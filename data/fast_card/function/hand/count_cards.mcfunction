# 使用clear的0数量模式只统计不移除，一次读取玩家物品栏中的全部Fast Card牌
execute store result score @s fc_count run clear @s minecraft:paper[minecraft:custom_data~{fast_card:{card:1b}}] 0
