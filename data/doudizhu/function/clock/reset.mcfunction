scoreboard players set @s dd_turn_clock 0
execute unless score @s dd_turn_limit matches 1.. run return 0
execute if score @s dd_state matches 2 if score @s dd_bidmode matches 2 run return 0
scoreboard players set #timed_human dd_ctx 0
execute as @a[tag=dd.audience,tag=ct.player] if score @s dd_seat = #turn dd_ctx run scoreboard players set #timed_human dd_ctx 1
execute unless score #timed_human dd_ctx matches 1 run return 0
scoreboard players set #turn_ticks_per_second dd_ctx 20
scoreboard players operation @s dd_turn_clock = @s dd_turn_limit
scoreboard players operation @s dd_turn_clock *= #turn_ticks_per_second dd_ctx
