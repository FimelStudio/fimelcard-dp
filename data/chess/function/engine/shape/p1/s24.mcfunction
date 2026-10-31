execute if score #to ch_ctx matches 16 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 17 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 17 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 17 if score #b25 ch_ctx matches 1 run function chess:engine/ep/s25
execute if score #to ch_ctx matches 32 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 33 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
