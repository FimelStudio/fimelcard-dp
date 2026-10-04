scoreboard objectives add wq_input dummy
scoreboard objectives add wq_form dummy
execute as @e[type=minecraft:marker,tag=ct.controller] unless score @s wq_input matches 0..1 run scoreboard players set @s wq_input 0
scoreboard players set #version wq_ctx 3
