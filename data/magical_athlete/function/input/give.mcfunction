execute unless entity @s[tag=ma.player,tag=ct.player] run return 0
execute unless score @s ma_table = @s ct_id run return 0
execute unless score @s ma_seat = @s ct_seat run return 0
execute if score @s ct_paused matches 1 run return 0
execute if items entity @s hotbar.8 * unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run return 0
execute store result storage magical_athlete:input table int 1 run scoreboard players get @s ma_table
execute unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:input/menu_tool with storage magical_athlete:input
