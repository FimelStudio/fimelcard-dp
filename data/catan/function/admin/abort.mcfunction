execute if entity @s[type=minecraft:marker,tag=ct.controller,scores={ct_game=21}] run return run function catan:game/abort
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=21,ct_state=1},sort=nearest,limit=1,distance=..8] at @s run function catan:game/abort
