# 注册游戏初始化分派：只负责为当前牌桌准备该游戏自己的默认设置
execute if score @s ct_game matches 1 run function fast_card:game/init_table
execute if score @s ct_game matches 2 run function liars_holdem:game/init_table
execute if score @s ct_game matches 3 run function hanabi:game/init_table
execute if score @s ct_game matches 4 run function abraca:game/init_table
