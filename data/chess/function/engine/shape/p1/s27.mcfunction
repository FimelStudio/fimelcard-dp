execute if score #to ch_ctx matches 18 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 18 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 18 if score #b26 ch_ctx matches 1 run function chess:engine/ep/s26
execute if score #to ch_ctx matches 19 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 20 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 20 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 20 if score #b28 ch_ctx matches 1 run function chess:engine/ep/s28
execute if score #to ch_ctx matches 34 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 35 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 36 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
