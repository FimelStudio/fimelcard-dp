scoreboard players remove @s gm_timer 1
execute if score @s gm_timer matches ..0 run function gomoku:game/cleanup
