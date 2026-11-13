scoreboard players set #wanted ac_ctx 0
execute as @e[tag=ac.sides,scores={ac_active=1}] run scoreboard players operation #wanted ac_ctx = @s ac_color
scoreboard players add #wanted ac_ctx 2
scoreboard players operation #wanted ac_ctx %= #four ac_ctx
execute as @e[tag=ac.sides] if score @s ac_color = #wanted ac_ctx run function aeroplane_chess:game/add_bot
