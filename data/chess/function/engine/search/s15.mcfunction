scoreboard players set #from ch_ctx 15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches 1 run function chess:engine/search/p1/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches 2 run function chess:engine/search/p2/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches 3 run function chess:engine/search/p3/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches 4 run function chess:engine/search/p4/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches 5 run function chess:engine/search/p5/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches 6 run function chess:engine/search/p6/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches -1 run function chess:engine/search/p1/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches -2 run function chess:engine/search/p2/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches -3 run function chess:engine/search/p3/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches -4 run function chess:engine/search/p4/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches -5 run function chess:engine/search/p5/s15
execute if score #found ch_ctx matches 0 if score #b15 ch_ctx matches -6 run function chess:engine/search/p6/s15
