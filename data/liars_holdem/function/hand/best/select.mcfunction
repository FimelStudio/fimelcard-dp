# 当前执行者是玩家，lh.eval_card中恰好是其两张手牌与本桌五张公共牌
scoreboard players set @s lh_b1 0
scoreboard players set @s lh_b2 0
scoreboard players set @s lh_b3 0
scoreboard players set @s lh_b4 0
scoreboard players set @s lh_b5 0
scoreboard players set #pick_index lh_ctx 1
tag @e[tag=lh.best_pool] remove lh.best_pool
tag @e[tag=lh.best_candidate] remove lh.best_candidate
execute as @e[tag=lh.eval_card] run tag @s add lh.best_pool

execute if score @s lh_cat matches 1 run function liars_holdem:hand/best/high
execute if score @s lh_cat matches 2 run function liars_holdem:hand/best/pair
execute if score @s lh_cat matches 3 run function liars_holdem:hand/best/two_pair
execute if score @s lh_cat matches 4 run function liars_holdem:hand/best/three
execute if score @s lh_cat matches 5 run function liars_holdem:hand/best/straight
execute if score @s lh_cat matches 6 run function liars_holdem:hand/best/flush
execute if score @s lh_cat matches 7 run function liars_holdem:hand/best/full_house
execute if score @s lh_cat matches 8 run function liars_holdem:hand/best/four
execute if score @s lh_cat matches 9..10 run function liars_holdem:hand/best/straight_flush

tag @e[tag=lh.best_pool] remove lh.best_pool
tag @e[tag=lh.best_candidate] remove lh.best_candidate
