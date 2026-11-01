# 最后一格只放一个菜单；不覆盖玩家已有物品。
clear @s minecraft:paper[minecraft:custom_data~{weiqi:{tool:1b}}]
execute store result storage weiqi:input table int 1 run scoreboard players get @s go_table
function weiqi:input/give_tool with storage weiqi:input
