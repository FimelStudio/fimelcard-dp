scoreboard objectives add dc_input dummy
scoreboard objectives add dc_form dummy
execute as @e[type=minecraft:marker,tag=ct.controller] unless score @s dc_input matches 0..1 run scoreboard players set @s dc_input 0
scoreboard players set #version dc_ctx 11
