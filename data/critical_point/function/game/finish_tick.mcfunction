scoreboard players remove @s cp_timer 1
execute if score @s cp_timer matches ..0 run function critical_point:game/abort

