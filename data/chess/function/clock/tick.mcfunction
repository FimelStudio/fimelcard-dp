execute if score @s ch_time matches 0 run return 0
execute if score @s ch_turn matches 1 run scoreboard players remove @s ch_wtime 1
execute if score @s ch_turn matches -1 run scoreboard players remove @s ch_btime 1
execute if score @s ch_turn matches 1 if score @s ch_wtime matches ..0 run function chess:game/timeout
execute if score @s ch_turn matches -1 if score @s ch_btime matches ..0 run function chess:game/timeout
