# 玩家直接调用：中止同维度 8 格内最近的花火对局，保留牌桌并返回大厅。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=hb.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[花火] ',color:'gold'},{text:'同维度 8 格内没有正在运行的花火牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=hb.controller,distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=hb.controller,distance=..8,sort=nearest,limit=1] at @s run function hanabi:game/abort
