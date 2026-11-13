execute if score #to ch_ctx matches 11 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 13 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 18 if score #b11 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 22 if score #b13 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 25 if score #b11 ch_ctx matches 0 if score #b18 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 31 if score #b13 ch_ctx matches 0 if score #b22 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 32 if score #b11 ch_ctx matches 0 if score #b18 ch_ctx matches 0 if score #b25 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
