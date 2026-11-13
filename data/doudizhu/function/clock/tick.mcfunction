execute if score @s ct_paused matches 1 run return 0
execute unless score @s dd_state matches 2..3 run return 0
execute if score @s dd_state matches 2 if score @s dd_bidmode matches 2 run return 0
execute unless score @s dd_turn_clock matches 1.. run return 0
scoreboard players remove @s dd_turn_clock 1
execute unless score @s dd_turn_clock matches 0 run return 0
scoreboard players operation #clock_table dd_ctx = @s dd_id
scoreboard players operation #clock_physical dd_ctx = @s ct_id
scoreboard players operation #clock_turn dd_ctx = @s dd_turn
execute as @a[tag=dd.player,tag=ct.player,tag=!ct.paused_return] unless score @s ct_paused matches 1 at @s if score @s dd_id = #clock_table dd_ctx if score @s ct_id = #clock_physical dd_ctx if score @s dd_seat = #clock_turn dd_ctx run function doudizhu:clock/submit
