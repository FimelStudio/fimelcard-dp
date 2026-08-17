# 删除附近牌桌的会话和交互实体，但故意保留玩家装饰过的方块结构
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'附近没有可移除的牌桌会话。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,distance=..8,sort=nearest,limit=1] run return fail

tag @s add ct.remove_actor
execute as @e[type=minecraft:marker,tag=ct.controller,distance=..8,sort=nearest,limit=1] at @s run function cardtable:table/remove
tag @s remove ct.remove_actor
