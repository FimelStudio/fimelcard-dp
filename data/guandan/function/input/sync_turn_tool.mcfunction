function guandan:input/tool_eligibility
execute if score #item_allowed gd_ctx matches 0 run clear @s *[minecraft:custom_data~{guandan:{tool:1b,action:0}}]
execute unless score #item_allowed gd_ctx matches 1 run return 0
execute store result storage guandan:input table int 1 run scoreboard players get @s gd_table
function guandan:input/ensure_turn_tool with storage guandan:input
