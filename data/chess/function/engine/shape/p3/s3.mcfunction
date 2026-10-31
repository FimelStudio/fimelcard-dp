execute if score #to ch_ctx matches 10 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 12 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 17 if score #b10 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 21 if score #b12 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 24 if score #b10 ch_ctx matches 0 if score #b17 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 30 if score #b12 ch_ctx matches 0 if score #b21 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 39 if score #b12 ch_ctx matches 0 if score #b21 ch_ctx matches 0 if score #b30 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
