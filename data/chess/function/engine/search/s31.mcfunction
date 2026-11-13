scoreboard players set #from ch_ctx 31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches 1 run function chess:engine/search/p1/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches 2 run function chess:engine/search/p2/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches 3 run function chess:engine/search/p3/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches 4 run function chess:engine/search/p4/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches 5 run function chess:engine/search/p5/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches 6 run function chess:engine/search/p6/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches -1 run function chess:engine/search/p1/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches -2 run function chess:engine/search/p2/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches -3 run function chess:engine/search/p3/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches -4 run function chess:engine/search/p4/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches -5 run function chess:engine/search/p5/s31
execute if score #found ch_ctx matches 0 if score #b31 ch_ctx matches -6 run function chess:engine/search/p6/s31
