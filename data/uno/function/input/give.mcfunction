# 手牌逻辑留在实体记分板；这里只提供快捷栏第1格的操作物。
clear @s minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}]
execute store result storage uno:input table int 1 run scoreboard players get @s un_table
function uno:input/give_tool with storage uno:input
