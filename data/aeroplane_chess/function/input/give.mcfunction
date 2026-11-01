function aeroplane_chess:input/tool_eligibility
clear @s minecraft:paper[minecraft:custom_data~{aeroplane_chess:{tool:1b}}]
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/tools with storage aeroplane_chess:input
