# 玩家直接调用：中止同维度 8 格内最近的临界点对局，保留牌桌并返回大厅。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=cp.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[临界点] ',color:'gold'},{text:'同维度 8 格内没有正在运行的临界点牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=cp.controller,distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=cp.controller,distance=..8,sort=nearest,limit=1] at @s run function critical_point:game/abort
