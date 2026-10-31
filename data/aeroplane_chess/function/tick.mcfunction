function aeroplane_chess:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=15},tag=!ac.controller] at @s run function aeroplane_chess:game/init_table
execute as @e[type=minecraft:marker,tag=ac.controller,scores={ct_game=15}] at @s run function aeroplane_chess:system/tick
