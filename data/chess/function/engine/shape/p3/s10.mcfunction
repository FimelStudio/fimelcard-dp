execute if score #to ch_ctx matches 1 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 3 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 17 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 19 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 24 if score #b17 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 28 if score #b19 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 37 if score #b19 ch_ctx matches 0 if score #b28 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 46 if score #b19 ch_ctx matches 0 if score #b28 ch_ctx matches 0 if score #b37 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 55 if score #b19 ch_ctx matches 0 if score #b28 ch_ctx matches 0 if score #b37 ch_ctx matches 0 if score #b46 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
