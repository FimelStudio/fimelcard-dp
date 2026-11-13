execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=23}] run return run function magical_athlete:game/abort
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23,ct_state=1},distance=..8] run tellraw @s {text:"[胡闹运动会] 同维度8格内没有进行中的胡闹运动会。",color:"yellow"}
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=23,ct_state=1},sort=nearest,limit=1,distance=..8] at @s run function magical_athlete:game/abort
