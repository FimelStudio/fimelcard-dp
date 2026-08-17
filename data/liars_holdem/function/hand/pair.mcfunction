function liars_holdem:hand/find_high_group {min:2}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players set @s lh_cat 2
scoreboard players operation @s lh_k1 = #group lh_ctx
function liars_holdem:hand/zero_group
function liars_holdem:hand/push_ranks
# 一对比较三张踢脚
scoreboard players set @s lh_k5 0
