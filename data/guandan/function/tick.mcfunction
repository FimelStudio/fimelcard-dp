function guandan:input/tick
execute as @e[type=minecraft:marker,tag=gd.controller,scores={ct_game=18,gd_state=1..5}] at @s run function guandan:game/tick
execute as @e[type=minecraft:marker,tag=gd.controller,scores={ct_game=18}] at @s run function guandan:visual/tick
