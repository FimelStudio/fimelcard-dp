execute if score #to ch_ctx matches 19 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 19 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 19 if score #b27 ch_ctx matches 1 run function chess:engine/ep/s27
execute if score #to ch_ctx matches 20 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 21 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 21 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 21 if score #b29 ch_ctx matches 1 run function chess:engine/ep/s29
execute if score #to ch_ctx matches 35 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 36 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 37 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
