function xiangqi:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=13},tag=!xq.controller] at @s run function xiangqi:game/init_table
execute as @e[type=minecraft:marker,tag=xq.controller,scores={ct_game=13}] at @s run function xiangqi:system/tick
