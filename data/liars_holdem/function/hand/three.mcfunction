function liars_holdem:hand/find_high_group {min:3}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players set @s lh_cat 4
scoreboard players operation @s lh_k1 = #group lh_ctx
function liars_holdem:hand/zero_group
function liars_holdem:hand/push_ranks
# 三条只比较两张踢脚
scoreboard players set @s lh_k4 0
scoreboard players set @s lh_k5 0
