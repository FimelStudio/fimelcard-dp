# 管理员后备入口；正常玩法应点击中央“开始游戏”
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0},distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'附近没有等待开始的牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0},distance=..8,sort=nearest,limit=1] run return fail

tag @s add ct.start_actor
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0},distance=..8,sort=nearest,limit=1] at @s run function cardtable:game/start
tag @s remove ct.start_actor
