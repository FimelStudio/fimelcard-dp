# 当前执行者是牌桌控制器，实际接收dialog的是带ct.settings_actor标签的点击玩家
execute if score @s ct_game matches 1 run return run function fast_card:settings/open
execute if score @s ct_game matches 2 run return run function liars_holdem:settings/open
execute if score @s ct_game matches 3 run return run function hanabi:settings/open
execute if score @s ct_game matches 4 run return run function abraca:settings/open
execute if score @s ct_game matches 5 run return run function bullshit:settings/open
execute if score @s ct_game matches 6 run return run function decrypto:settings/open
execute if score @s ct_game matches 7 run return run function critical_point:settings/open
execute if score @s ct_game matches 8 run return run function wenfei:settings/open
execute if score @s ct_game matches 9 run return run function skull:settings/open
execute if score @s ct_game matches 10 run return run function doudizhu:settings/open
execute if score @s ct_game matches 11 run return run function uno:settings/open

execute if score @s ct_game matches 12 run return run function chess:settings/open
tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'当前游戏没有提供设置界面。',color:'yellow'}]
