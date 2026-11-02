# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s xq_time matches 0 run return 0
execute if score @s xq_turn matches 1 run scoreboard players remove @s xq_rtime 1
execute if score @s xq_turn matches -1 run scoreboard players remove @s xq_btime 1
execute if score @s xq_turn matches 1 if score @s xq_rtime matches ..0 run function xiangqi:game/timeout
execute if score @s xq_turn matches -1 if score @s xq_btime matches ..0 run function xiangqi:game/timeout
