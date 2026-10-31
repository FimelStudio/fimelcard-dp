execute if score #to ch_ctx matches 3 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 5 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 19 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 21 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 26 if score #b19 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 30 if score #b21 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 33 if score #b19 ch_ctx matches 0 if score #b26 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 39 if score #b21 ch_ctx matches 0 if score #b30 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 40 if score #b19 ch_ctx matches 0 if score #b26 ch_ctx matches 0 if score #b33 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
