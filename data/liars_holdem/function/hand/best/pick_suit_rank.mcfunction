# 同花和同花顺还必须限定花色
tag @e[tag=lh.best_candidate] remove lh.best_candidate
execute as @e[tag=lh.best_pool] if score @s lh_rank = #pick_rank lh_ctx if score @s lh_suit = #pick_suit lh_ctx run tag @s add lh.best_candidate
execute if score #pick_index lh_ctx matches 1 run scoreboard players operation @s lh_b1 = @e[tag=lh.best_candidate,limit=1] lh_card
execute if score #pick_index lh_ctx matches 2 run scoreboard players operation @s lh_b2 = @e[tag=lh.best_candidate,limit=1] lh_card
execute if score #pick_index lh_ctx matches 3 run scoreboard players operation @s lh_b3 = @e[tag=lh.best_candidate,limit=1] lh_card
execute if score #pick_index lh_ctx matches 4 run scoreboard players operation @s lh_b4 = @e[tag=lh.best_candidate,limit=1] lh_card
execute if score #pick_index lh_ctx matches 5 run scoreboard players operation @s lh_b5 = @e[tag=lh.best_candidate,limit=1] lh_card
tag @e[tag=lh.best_candidate,limit=1] remove lh.best_pool
tag @e[tag=lh.best_candidate] remove lh.best_candidate
scoreboard players add #pick_index lh_ctx 1
