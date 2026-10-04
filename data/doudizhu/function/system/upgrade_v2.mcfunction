scoreboard objectives add dd_humans dummy
scoreboard objectives add dd_bot_timer dummy
tag @a[tag=dd.player] add dd.actor
execute as @e[tag=dd.controller] unless score @s dd_humans matches 1..3 run scoreboard players set @s dd_humans 3
scoreboard players set @e[tag=dd.controller] dd_bot_timer 0
scoreboard players set #version dd_ctx 2
