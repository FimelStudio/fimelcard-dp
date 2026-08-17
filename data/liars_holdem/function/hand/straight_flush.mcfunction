# 找到唯一可能达到五张的花色，并建立该花色各点数存在表
scoreboard players set #flush_suit lh_ctx 0
execute if score #s1 lh_ctx matches 5.. run scoreboard players set #flush_suit lh_ctx 1
execute if score #s2 lh_ctx matches 5.. run scoreboard players set #flush_suit lh_ctx 2
execute if score #s3 lh_ctx matches 5.. run scoreboard players set #flush_suit lh_ctx 3
execute if score #s4 lh_ctx matches 5.. run scoreboard players set #flush_suit lh_ctx 4

tag @e[tag=lh.flush_card] remove lh.flush_card
execute if score #flush_suit lh_ctx matches 1 as @e[tag=lh.eval_card,scores={lh_suit=1}] run tag @s add lh.flush_card
execute if score #flush_suit lh_ctx matches 2 as @e[tag=lh.eval_card,scores={lh_suit=2}] run tag @s add lh.flush_card
execute if score #flush_suit lh_ctx matches 3 as @e[tag=lh.eval_card,scores={lh_suit=3}] run tag @s add lh.flush_card
execute if score #flush_suit lh_ctx matches 4 as @e[tag=lh.eval_card,scores={lh_suit=4}] run tag @s add lh.flush_card
function liars_holdem:hand/count_flush_ranks
function liars_holdem:hand/find_flush_straight

execute if score #straight lh_ctx matches 14 run scoreboard players set @s lh_cat 10
execute if score #straight lh_ctx matches 5..13 run scoreboard players set @s lh_cat 9
execute if score #straight lh_ctx matches 5.. run scoreboard players operation @s lh_k1 = #straight lh_ctx
tag @e[tag=lh.flush_card] remove lh.flush_card
