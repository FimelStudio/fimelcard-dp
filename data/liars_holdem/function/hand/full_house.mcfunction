function liars_holdem:hand/find_high_group {min:3}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players operation #trip lh_ctx = #group lh_ctx
scoreboard players operation #exclude lh_ctx = #trip lh_ctx
function liars_holdem:hand/find_high_group_excluding {min:2}
execute if score #group lh_ctx matches 0 run return 0
scoreboard players set @s lh_cat 7
scoreboard players operation @s lh_k1 = #trip lh_ctx
scoreboard players operation @s lh_k2 = #group lh_ctx
