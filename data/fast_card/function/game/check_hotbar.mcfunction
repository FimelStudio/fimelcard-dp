# 逐槽检测，避免读取或修改玩家完整物品栏数据
execute if items entity @s hotbar.0 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.1 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.2 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.3 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.4 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.5 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.6 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.7 * run scoreboard players set #blocked fc_ctx 1
execute if items entity @s hotbar.8 * run scoreboard players set #blocked fc_ctx 1
execute if score #blocked fc_ctx matches 1 run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'开始前请清空九个快捷栏槽位。',color:'red'}]
