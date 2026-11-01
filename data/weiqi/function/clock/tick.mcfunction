execute unless score @s go_state matches 1 run return 0
execute if score @s go_time matches 0 run return 0
execute if score @s go_turn matches 1 run scoreboard players remove @s go_btime 1
execute if score @s go_turn matches -1 run scoreboard players remove @s go_wtime 1
execute if score @s go_turn matches 1 if score @s go_btime matches ..0 run function weiqi:game/timeout
execute if score @s go_turn matches -1 if score @s go_wtime matches ..0 run function weiqi:game/timeout
