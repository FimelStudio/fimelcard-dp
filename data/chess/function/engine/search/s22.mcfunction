scoreboard players set #from ch_ctx 22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches 1 run function chess:engine/search/p1/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches 2 run function chess:engine/search/p2/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches 3 run function chess:engine/search/p3/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches 4 run function chess:engine/search/p4/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches 5 run function chess:engine/search/p5/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches 6 run function chess:engine/search/p6/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches -1 run function chess:engine/search/p1/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches -2 run function chess:engine/search/p2/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches -3 run function chess:engine/search/p3/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches -4 run function chess:engine/search/p4/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches -5 run function chess:engine/search/p5/s22
execute if score #found ch_ctx matches 0 if score #b22 ch_ctx matches -6 run function chess:engine/search/p6/s22
