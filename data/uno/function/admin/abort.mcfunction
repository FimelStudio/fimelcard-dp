# 可直接 /function 调用；只处理同维度八格内最近的一场 UNO。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[UNO] 同维度 8 格内没有正在运行的 UNO 牌桌。',color:'red'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=un.controller,distance=..8,sort=nearest,limit=1] at @s run function uno:game/abort
