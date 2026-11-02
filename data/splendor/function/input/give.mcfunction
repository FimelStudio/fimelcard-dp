execute unless entity @s[tag=sp.player,tag=ct.player] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute if score @s ct_paused matches 1 run return 0
execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run return 0
execute store result storage splendor:input table int 1 run scoreboard players get @s sp_table
execute unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{splendor:{tool:1b}}] run function splendor:input/menu_tool with storage splendor:input
