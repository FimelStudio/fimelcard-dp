function weiqi:input/tick
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_game=20},tag=!go.controller] at @s run function weiqi:game/init_table
execute as @e[type=minecraft:marker,tag=go.controller,scores={ct_game=20}] at @s run function weiqi:system/tick
