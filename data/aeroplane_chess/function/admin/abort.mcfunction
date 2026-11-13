execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[飞行棋] 同维度 8 格内没有进行中的飞行棋。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ac.controller,scores={ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function aeroplane_chess:game/abort
