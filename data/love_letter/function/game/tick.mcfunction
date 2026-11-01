execute if score @s ll_state matches 1 run function love_letter:deal/tick
execute if score @s ll_state matches 2 run function love_letter:game/live_tick
execute if score @s ll_state matches 3..4 run function love_letter:game/result_tick
scoreboard players add @s ll_tick 1
execute if score @s ll_tick matches 20.. run function love_letter:game/maintenance
