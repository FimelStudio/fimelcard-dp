execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[掼蛋] 同维度8格内没有进行中的掼蛋。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=gd.controller,scores={ct_game=18,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function guandan:game/abort
