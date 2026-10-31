scoreboard players set #from ch_ctx 58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches 1 run function chess:engine/search/p1/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches 2 run function chess:engine/search/p2/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches 3 run function chess:engine/search/p3/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches 4 run function chess:engine/search/p4/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches 5 run function chess:engine/search/p5/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches 6 run function chess:engine/search/p6/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches -1 run function chess:engine/search/p1/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches -2 run function chess:engine/search/p2/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches -3 run function chess:engine/search/p3/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches -4 run function chess:engine/search/p4/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches -5 run function chess:engine/search/p5/s58
execute if score #found ch_ctx matches 0 if score #b58 ch_ctx matches -6 run function chess:engine/search/p6/s58
