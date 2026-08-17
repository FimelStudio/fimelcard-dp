# 中止附近最近的Fast Card游戏；方块牌桌和大厅会保留
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1..5},distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'附近没有正在进行的Fast Card游戏。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1..5},distance=..8,sort=nearest,limit=1] run return fail

tag @s add fc.admin
execute as @e[type=minecraft:marker,tag=fc.controller,scores={fc_state=1..5},distance=..8,sort=nearest,limit=1] at @s run function fast_card:game/abort
tag @s remove fc.admin
