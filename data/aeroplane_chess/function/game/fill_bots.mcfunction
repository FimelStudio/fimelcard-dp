execute if score @s ac_players matches 1 if score @s ac_fill matches 0..1 run function aeroplane_chess:game/add_opposite
execute if score @s ac_fill matches 1 as @e[tag=ac.sides,scores={ac_active=0}] run function aeroplane_chess:game/add_bot
