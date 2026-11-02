execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=22}] run return run function splendor:game/abort
execute unless entity @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1},distance=..8] run tellraw @s {text:"[璀璨宝石] 同维度8格内没有进行中的璀璨宝石。",color:"yellow"}
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=22,ct_state=1},sort=nearest,limit=1,distance=..8] at @s run function splendor:game/abort
