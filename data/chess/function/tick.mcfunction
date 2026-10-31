function chess:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=12},tag=!ch.controller] at @s run function chess:game/init_table
execute as @e[type=minecraft:marker,tag=ch.controller,scores={ct_game=12}] at @s run function chess:system/tick
