function love_letter:input/tick
execute as @e[type=minecraft:marker,tag=ll.controller,scores={ct_game=17}] at @s run function love_letter:visual/tick
execute as @e[type=minecraft:marker,tag=ll.controller,scores={ct_game=17,ll_state=1..4}] at @s run function love_letter:game/tick
