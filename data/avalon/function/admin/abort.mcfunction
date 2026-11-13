# 玩家管理入口：中止同维度 8 格内最近一场阿瓦隆，保留牌桌。
execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=av.controller,scores={ct_game=16,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[阿瓦隆] 同维度 8 格内没有正在运行的阿瓦隆牌桌。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=av.controller,scores={ct_game=16,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=av.controller,scores={ct_game=16,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function avalon:game/abort
