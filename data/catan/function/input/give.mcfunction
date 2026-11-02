execute unless entity @s[tag=ca.player,tag=ct.player] run return 0
execute store result storage catan:input table int 1 run scoreboard players get @s ca_table
execute unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:0}}] run function catan:input/menu_tool with storage catan:input
scoreboard players set #aim ca_ctx 0
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=1..2,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=6,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=8,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run scoreboard players set #aim ca_ctx 0
execute if score #aim ca_ctx matches 1 unless items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:1}}] run function catan:input/aim_tool with storage catan:input
execute if score #aim ca_ctx matches 0 if items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:1}}] run item replace entity @s hotbar.0 with minecraft:air
