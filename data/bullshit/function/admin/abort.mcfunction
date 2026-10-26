# 玩家直接调用：中止同维度 8 格内最近的瞎掰王对局，保留牌桌并返回大厅。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=bw.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[瞎掰王] ',color:'gold'},{text:'同维度 8 格内没有正在运行的瞎掰王牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=bw.controller,distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=bw.controller,distance=..8,sort=nearest,limit=1] at @s run function bullshit:game/abort
