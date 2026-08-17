function liars_holdem:hand/find_high_group {min:2}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players operation #pair1 lh_ctx = #group lh_ctx
scoreboard players operation #exclude lh_ctx = #pair1 lh_ctx
function liars_holdem:hand/find_high_group_excluding {min:2}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players operation #pair2 lh_ctx = #group lh_ctx

scoreboard players set @s lh_cat 3
scoreboard players operation @s lh_k1 = #pair1 lh_ctx
scoreboard players operation @s lh_k2 = #pair2 lh_ctx
scoreboard players operation #group lh_ctx = #pair1 lh_ctx
function liars_holdem:hand/zero_group
scoreboard players operation #group lh_ctx = #pair2 lh_ctx
function liars_holdem:hand/zero_group
function liars_holdem:hand/push_ranks
# 两对只比较一张踢脚
scoreboard players set @s lh_k4 0
scoreboard players set @s lh_k5 0
