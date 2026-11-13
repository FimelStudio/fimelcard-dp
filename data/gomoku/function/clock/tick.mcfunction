# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s gm_time matches 0 run return 0
execute if score @s gm_turn matches 1 run scoreboard players remove @s gm_btime 1
execute if score @s gm_turn matches -1 run scoreboard players remove @s gm_wtime 1
execute if score @s gm_turn matches 1 if score @s gm_btime matches ..0 run function gomoku:game/timeout
execute if score @s gm_turn matches -1 if score @s gm_wtime matches ..0 run function gomoku:game/timeout
