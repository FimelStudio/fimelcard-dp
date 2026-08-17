function liars_holdem:hand/find_straight
execute if score #straight lh_ctx matches 0 run return 0
scoreboard players set @s lh_cat 5
scoreboard players operation @s lh_k1 = #straight lh_ctx
