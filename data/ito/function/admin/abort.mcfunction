execute unless entity @e[type=minecraft:marker,tag=it.controller,distance=..8] run return fail
execute as @e[type=minecraft:marker,tag=it.controller,distance=..8,sort=nearest,limit=1] at @s run function ito:game/abort
