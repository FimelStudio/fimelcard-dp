# 当前阶段所有未弃牌玩家已经行动
execute if score @s lh_state matches 5 run return run function liars_holdem:community/reveal_flop
execute if score @s lh_state matches 7 run return run function liars_holdem:community/reveal_turn
execute if score @s lh_state matches 9 run return run function liars_holdem:community/reveal_river
execute if score @s lh_state matches 11 run return run function liars_holdem:showdown/start
execute if score @s lh_state matches 12 run return run function liars_holdem:community/reveal_all
