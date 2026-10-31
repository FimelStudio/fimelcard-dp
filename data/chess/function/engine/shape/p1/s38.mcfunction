execute if score #to ch_ctx matches 29 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 30 if score #side ch_ctx matches -1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 31 if score #side ch_ctx matches -1 if score #target ch_ctx matches 1..6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 45 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 45 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 45 if score #b37 ch_ctx matches -1 run function chess:engine/ep/s37
execute if score #to ch_ctx matches 46 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 47 if score #side ch_ctx matches 1 if score #target ch_ctx matches -6..-1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 47 if score #side ch_ctx matches 1 if score #target ch_ctx matches 0 if score #ep ch_ctx matches 47 if score #b39 ch_ctx matches -1 run function chess:engine/ep/s39
