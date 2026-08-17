# 两张手牌和两个操作物品需要占用快捷栏，开始前要求九格全部为空
execute if items entity @s hotbar.0 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.1 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.2 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.3 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.4 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.5 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.6 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.7 * run scoreboard players set #blocked lh_ctx 1
execute if items entity @s hotbar.8 * run scoreboard players set #blocked lh_ctx 1
execute if score #blocked lh_ctx matches 1 run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'开始前请清空九个快捷栏槽位。',color:'yellow'}]
