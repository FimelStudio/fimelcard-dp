# 当前执行者是牌桌控制器，实际接收dialog的是带ct.rules_actor标签的点击玩家
execute if score @s ct_game matches 1 run return run function fast_card:rules/show
execute if score @s ct_game matches 2 run return run function liars_holdem:rules/show
execute if score @s ct_game matches 3 run return run function hanabi:rules/show
execute if score @s ct_game matches 4 run return run function abraca:rules/show
execute if score @s ct_game matches 5 run return run function bullshit:rules/show
execute if score @s ct_game matches 6 run return run function decrypto:rules/show
execute if score @s ct_game matches 7 run return run function critical_point:rules/show
execute if score @s ct_game matches 8 run return run function wenfei:rules/show
execute if score @s ct_game matches 9 run return run function skull:rules/show

tellraw @a[tag=ct.rules_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'当前游戏没有提供规则介绍。',color:'yellow'}]
