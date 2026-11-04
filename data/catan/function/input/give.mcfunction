execute unless entity @s[tag=ca.player,tag=ct.player] run return 0
execute unless score @s ca_table = @s ct_id run return 0
execute if score @s ct_paused matches 1 run return 0
execute store result storage catan:input table int 1 run scoreboard players get @s ca_table
execute unless items entity @s hotbar.7 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:0}}] run function catan:input/menu_tool with storage catan:input
execute unless items entity @s hotbar.8 minecraft:purple_dye[minecraft:custom_data~{catan:{tool:1b}}] run function catan:direct/dye_item with storage catan:input
function catan:direct/buildings
execute unless score @s ca_inv_epoch = @e[tag=ca.current,limit=1] ca_epoch run function catan:direct/resources
