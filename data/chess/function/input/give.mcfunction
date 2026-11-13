# 最后一格：对局菜单；同时替换旧版三个专属操作物。
clear @s minecraft:paper[minecraft:custom_data~{chess:{tool:1b}}]
execute store result storage chess:input table int 1 run scoreboard players get @s ch_table
function chess:input/give_tool with storage chess:input
