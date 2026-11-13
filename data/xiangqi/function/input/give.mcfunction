# 最后一格：对局菜单；同时替换旧版三个专属操作物。
clear @s minecraft:paper[minecraft:custom_data~{xiangqi:{tool:1b}}]
execute store result storage xiangqi:input table int 1 run scoreboard players get @s xq_table
function xiangqi:input/give_tool with storage xiangqi:input
