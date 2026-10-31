execute if score @s gm_time matches 0 run return 0
execute if score @s gm_turn matches 1 run scoreboard players remove @s gm_btime 1
execute if score @s gm_turn matches -1 run scoreboard players remove @s gm_wtime 1
execute if score @s gm_turn matches 1 if score @s gm_btime matches ..0 run function gomoku:game/timeout
execute if score @s gm_turn matches -1 if score @s gm_wtime matches ..0 run function gomoku:game/timeout
