function aeroplane_chess:input/tool_eligibility
execute if score #item_allowed ac_ctx matches 0 run clear @s *[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:1}}]
execute unless score #item_allowed ac_ctx matches 1 run return 0
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/ensure_turn_tool with storage aeroplane_chess:input
