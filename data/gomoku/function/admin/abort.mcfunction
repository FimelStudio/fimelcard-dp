# 可直接 /function 调用；只处理同维度八格内最近的一场五子棋。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s [{text:'[五子棋] 同维度 8 格内没有正在运行的五子棋牌桌。',color:'black'}]
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gm.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function gomoku:game/abort
