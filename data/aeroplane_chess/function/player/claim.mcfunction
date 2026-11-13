execute as @e[tag=ac.sides,scores={ac_active=0}] if score @s ac_color = #wanted ac_ctx run scoreboard players set #claimed ac_ctx 1
execute if score #claimed ac_ctx matches 1 as @e[tag=ac.sides] if score @s ac_color = #wanted ac_ctx run scoreboard players set @s ac_active 1
