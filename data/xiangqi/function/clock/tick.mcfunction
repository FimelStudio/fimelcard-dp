execute if score @s xq_time matches 0 run return 0
execute if score @s xq_turn matches 1 run scoreboard players remove @s xq_rtime 1
execute if score @s xq_turn matches -1 run scoreboard players remove @s xq_btime 1
execute if score @s xq_turn matches 1 if score @s xq_rtime matches ..0 run function xiangqi:game/timeout
execute if score @s xq_turn matches -1 if score @s xq_btime matches ..0 run function xiangqi:game/timeout
