# 手牌和 HUD 始终保留；操作物只在本人的正常行动回合提供。
execute unless entity @s[tag=un.player,tag=ct.player] run return 0
execute unless score @s un_table = @s ct_id run return 0
scoreboard players operation #tool_table un_ctx = @s un_table
scoreboard players operation #tool_seat un_ctx = @s un_seat
scoreboard players set #tool_allowed un_ctx 0
execute as @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,scores={ct_game=11,un_state=2}] if score @s ct_id = #tool_table un_ctx if score @s un_turn = #tool_seat un_ctx run scoreboard players set #tool_allowed un_ctx 1
execute unless score #tool_allowed un_ctx matches 1 run clear @s minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}]
execute unless score #tool_allowed un_ctx matches 1 run return 0
execute store result score #tool_have un_ctx run clear @s minecraft:purple_dye[minecraft:custom_data~{uno:{tool:1b}}] 0
execute if score #tool_have un_ctx matches 1.. run return 0
execute store result storage uno:input table int 1 run scoreboard players get @s un_table
function uno:input/give_tool with storage uno:input
