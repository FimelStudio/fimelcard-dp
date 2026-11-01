# F会把主手牌交换到副手；先读取牌位，再清除副手中的操作副本
scoreboard players set #slot hb_ctx 0
execute if items entity @s weapon.offhand minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,slot:1}}] run scoreboard players set #slot hb_ctx 1
execute if items entity @s weapon.offhand minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,slot:2}}] run scoreboard players set #slot hb_ctx 2
execute if items entity @s weapon.offhand minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,slot:3}}] run scoreboard players set #slot hb_ctx 3
execute if items entity @s weapon.offhand minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,slot:4}}] run scoreboard players set #slot hb_ctx 4
execute if items entity @s weapon.offhand minecraft:paper[minecraft:custom_data~{hanabi:{card:1b,slot:5}}] run scoreboard players set #slot hb_ctx 5
item replace entity @s weapon.offhand with minecraft:air

execute unless score #slot hb_ctx matches 1..5 run function hanabi:hand/sync
execute unless score #slot hb_ctx matches 1..5 run return 0
execute unless entity @s[tag=hb.turn] run function hanabi:hand/sync
execute unless entity @s[tag=hb.turn] run return 0

scoreboard players operation @s hb_action = #slot hb_ctx
scoreboard players add @s hb_action 200
function hanabi:action/handle
execute if entity @s[tag=hb.player] run function hanabi:hand/sync
