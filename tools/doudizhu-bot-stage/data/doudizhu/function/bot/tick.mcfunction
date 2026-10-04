scoreboard players add @s dd_bot_timer 1
execute unless score @s dd_bot_timer matches 20.. run return 0
scoreboard players set @s dd_bot_timer 0
scoreboard players operation #ctx dd_ctx = @s dd_id
scoreboard players operation #bot_turn dd_ctx = @s dd_turn
execute as @e[type=minecraft:marker,tag=dd.bot] if score @s dd_id = #ctx dd_ctx if score @s dd_seat = #bot_turn dd_ctx run function doudizhu:bot/act
