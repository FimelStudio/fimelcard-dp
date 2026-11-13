execute if score #to ch_ctx matches 22 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 22 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 22 if score #b30 ch_ctx matches 1 run function chess:engine/ep/s30
execute if score #to ch_ctx matches 23 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 38 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 39 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
