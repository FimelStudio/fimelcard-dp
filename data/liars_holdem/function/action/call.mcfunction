# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 普通阶段Q丢Call只增加1发；提前ALL IN统一由F键触发
execute if score @s lh_state matches 5 run return run function liars_holdem:action/normal_call
execute if score @s lh_state matches 7 run return run function liars_holdem:action/normal_call
execute if score @s lh_state matches 9 run return run function liars_holdem:action/normal_call
execute if score @s lh_state matches 11 run return run function liars_holdem:action/all_in
execute if score @s lh_state matches 12 run return run function liars_holdem:action/follow_allin
