scoreboard players set #from ch_ctx 8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches 1 run function chess:engine/search/p1/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches 2 run function chess:engine/search/p2/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches 3 run function chess:engine/search/p3/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches 4 run function chess:engine/search/p4/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches 5 run function chess:engine/search/p5/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches 6 run function chess:engine/search/p6/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches -1 run function chess:engine/search/p1/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches -2 run function chess:engine/search/p2/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches -3 run function chess:engine/search/p3/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches -4 run function chess:engine/search/p4/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches -5 run function chess:engine/search/p5/s8
execute if score #found ch_ctx matches 0 if score #b8 ch_ctx matches -6 run function chess:engine/search/p6/s8
