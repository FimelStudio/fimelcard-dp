execute if score #to ch_ctx matches 26 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 27 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 28 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 42 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 42 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 42 if score #b34 ch_ctx matches -1 run function chess:engine/ep/s34
execute if score #to ch_ctx matches 43 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 44 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 44 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 44 if score #b36 ch_ctx matches -1 run function chess:engine/ep/s36
