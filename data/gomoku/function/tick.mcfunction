function gomoku:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=14},tag=!gm.controller] at @s run function gomoku:game/init_table
execute as @e[type=minecraft:marker,tag=gm.controller,scores={ct_game=14}] at @s run function gomoku:system/tick
