scoreboard players operation #bot_table dd_ctx = @s dd_id
scoreboard players operation #bot_seat dd_ctx = @s dd_seat
scoreboard players operation #bot_lord dd_ctx = @e[tag=dd.current,limit=1] dd_lord
scoreboard players set #bot_total dd_ctx 0
execute as @e[tag=dd.hand] run scoreboard players add #bot_total dd_ctx 1
scoreboard players set #bot_friend dd_ctx 0
execute unless score #bot_probe dd_ctx matches 1 if score #bot_type dd_ctx matches 1.. unless score #bot_seat dd_ctx = #bot_lord dd_ctx unless score @e[tag=dd.current,limit=1] dd_last = #bot_lord dd_ctx run scoreboard players set #bot_friend dd_ctx 1
scoreboard players set #bot_enemy_min dd_ctx 99
execute as @e[tag=dd.actor] if score @s dd_id = #bot_table dd_ctx unless score @s dd_seat = #bot_seat dd_ctx run function doudizhu:bot/opponent_count
