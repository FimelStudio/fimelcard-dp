# 普通阶段Q丢Call只增加1发；提前ALL IN统一由F键触发
execute if score @s lh_state matches 5 run return run function liars_holdem:action/normal_call
execute if score @s lh_state matches 7 run return run function liars_holdem:action/normal_call
execute if score @s lh_state matches 9 run return run function liars_holdem:action/normal_call
execute if score @s lh_state matches 11 run return run function liars_holdem:action/all_in
execute if score @s lh_state matches 12 run return run function liars_holdem:action/follow_allin
