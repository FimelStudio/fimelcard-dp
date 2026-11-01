# 同步只移除非行动方的骰子，不重发已有骰子或菜单。
function aeroplane_chess:input/tool_eligibility
execute unless score #item_allowed ac_ctx matches 1 run clear @s *[minecraft:custom_data~{aeroplane_chess:{tool:1b,action:1}}]
execute unless score #item_allowed ac_ctx matches 1 run return 0
execute store result storage aeroplane_chess:input table int 1 run scoreboard players get @s ac_table
function aeroplane_chess:input/ensure_turn_tool with storage aeroplane_chess:input
