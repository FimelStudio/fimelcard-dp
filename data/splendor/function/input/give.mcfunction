execute unless entity @s[tag=sp.player,tag=ct.player] run return 0
execute unless score @s sp_table = @s ct_id run return 0
execute store result storage splendor:input table int 1 run scoreboard players get @s sp_table
execute unless items entity @s hotbar.8 minecraft:purple_dye[minecraft:custom_data~{splendor:{tool:1b}}] run function splendor:direct/dye_item with storage splendor:input
function splendor:direct/inventory
