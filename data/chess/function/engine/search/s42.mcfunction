scoreboard players set #from ch_ctx 42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches 1 run function chess:engine/search/p1/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches 2 run function chess:engine/search/p2/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches 3 run function chess:engine/search/p3/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches 4 run function chess:engine/search/p4/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches 5 run function chess:engine/search/p5/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches 6 run function chess:engine/search/p6/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches -1 run function chess:engine/search/p1/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches -2 run function chess:engine/search/p2/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches -3 run function chess:engine/search/p3/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches -4 run function chess:engine/search/p4/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches -5 run function chess:engine/search/p5/s42
execute if score #found ch_ctx matches 0 if score #b42 ch_ctx matches -6 run function chess:engine/search/p6/s42
