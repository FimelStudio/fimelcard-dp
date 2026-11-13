function guandan:input/tool_eligibility
clear @s *[minecraft:custom_data~{guandan:{tool:1b}}]
execute store result storage guandan:input table int 1 run scoreboard players get @s gd_table
function guandan:input/give_tools with storage guandan:input
