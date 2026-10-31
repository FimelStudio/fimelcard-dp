# 最后一格：对局菜单；同时替换旧版三个专属操作物。
clear @s minecraft:paper[minecraft:custom_data~{gomoku:{tool:1b}}]
execute store result storage gomoku:input table int 1 run scoreboard players get @s gm_table
function gomoku:input/give_tool with storage gomoku:input
