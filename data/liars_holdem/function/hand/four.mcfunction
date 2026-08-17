function liars_holdem:hand/find_high_group {min:4}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players set @s lh_cat 8
scoreboard players operation @s lh_k1 = #group lh_ctx
function liars_holdem:hand/zero_group
function liars_holdem:hand/push_ranks
# 四条只比较一张踢脚，其他比较位必须保持0
scoreboard players set @s lh_k3 0
scoreboard players set @s lh_k4 0
scoreboard players set @s lh_k5 0
