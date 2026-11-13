scoreboard players operation #deal_seat dd_ctx = @s dd_turn
execute as @e[tag=dd.actors] if score @s dd_seat = #deal_seat dd_ctx run function doudizhu:deal/hand
