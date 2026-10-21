execute unless score @s dd_state matches 3 run return 0
execute if score @s dd_type matches 0 run return 0
execute unless score @s dd_turn = @s dd_auto_seat run return 0
scoreboard players operation #auto_table dd_ctx = @s dd_id
scoreboard players operation #auto_turn dd_ctx = @s dd_turn
execute as @a[tag=dd.player,tag=ct.player] if score @s dd_id = #auto_table dd_ctx if score @s ct_id = #auto_table dd_ctx if score @s dd_seat = #auto_turn dd_ctx run function doudizhu:autopass/submit
