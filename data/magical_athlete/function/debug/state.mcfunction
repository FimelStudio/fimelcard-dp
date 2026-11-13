execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=23}] run return run function magical_athlete:debug/controller
tag @a[tag=ma.debug_actor] remove ma.debug_actor
tag @s add ma.debug_actor
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23},distance=..8] run tellraw @s {text:"[胡闹运动会 Debug] 同维度8格内没有本游戏牌桌。",color:"yellow"}
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23},distance=..8,sort=nearest,limit=1] at @s run function magical_athlete:debug/show
tag @s remove ma.debug_actor
