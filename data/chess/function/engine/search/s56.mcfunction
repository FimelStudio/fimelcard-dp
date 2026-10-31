scoreboard players set #from ch_ctx 56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches 1 run function chess:engine/search/p1/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches 2 run function chess:engine/search/p2/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches 3 run function chess:engine/search/p3/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches 4 run function chess:engine/search/p4/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches 5 run function chess:engine/search/p5/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches 6 run function chess:engine/search/p6/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches -1 run function chess:engine/search/p1/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches -2 run function chess:engine/search/p2/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches -3 run function chess:engine/search/p3/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches -4 run function chess:engine/search/p4/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches -5 run function chess:engine/search/p5/s56
execute if score #found ch_ctx matches 0 if score #b56 ch_ctx matches -6 run function chess:engine/search/p6/s56
