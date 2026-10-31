execute if score #to ch_ctx matches 12 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 14 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 19 if score #b12 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 23 if score #b14 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 26 if score #b12 ch_ctx matches 0 if score #b19 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 33 if score #b12 ch_ctx matches 0 if score #b19 ch_ctx matches 0 if score #b26 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 40 if score #b12 ch_ctx matches 0 if score #b19 ch_ctx matches 0 if score #b26 ch_ctx matches 0 if score #b33 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
