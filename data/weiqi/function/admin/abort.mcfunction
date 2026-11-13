execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[围棋] 同维度 8 格内没有正在运行的围棋牌桌。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=go.controller,scores={ct_game=20,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function weiqi:game/abort
