execute as @e[type=minecraft:interaction,tag=ac.dice_click] if data entity @s interaction at @s run function aeroplane_chess:input/dice
execute as @e[type=minecraft:interaction,tag=ac.plane_click] if data entity @s interaction at @s run function aeroplane_chess:input/plane
execute as @a[tag=ac.player,scores={ac_drop=1..}] at @s run function aeroplane_chess:input/drop
execute as @a[tag=ac.player,scores={ac_action=1..}] at @s run function aeroplane_chess:input/submit
execute as @a[scores={ac_settings=1..}] at @s run function aeroplane_chess:settings/save
