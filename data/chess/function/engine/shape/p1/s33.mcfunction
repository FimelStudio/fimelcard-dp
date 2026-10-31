execute if score #to ch_ctx matches 24 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 25 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 26 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 40 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 40 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 40 if score #b32 ch_ctx matches -1 run function chess:engine/ep/s32
execute if score #to ch_ctx matches 41 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 42 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 42 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 42 if score #b34 ch_ctx matches -1 run function chess:engine/ep/s34
