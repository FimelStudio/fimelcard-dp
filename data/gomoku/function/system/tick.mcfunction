scoreboard players add @s gm_pulse 1
execute if score @s gm_state matches 1 run function gomoku:clock/tick
execute if score @s gm_state matches 2 run function gomoku:game/animate_tick
execute if score @s gm_state matches 4 run function gomoku:game/result_tick
execute if score @s gm_state matches 1 run function gomoku:ai/tick
execute if score @s gm_pulse matches 20.. run function gomoku:system/heartbeat
