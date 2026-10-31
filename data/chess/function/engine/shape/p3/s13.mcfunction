execute if score #to ch_ctx matches 4 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 6 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 20 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 22 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 27 if score #b20 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 31 if score #b22 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 34 if score #b20 ch_ctx matches 0 if score #b27 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 41 if score #b20 ch_ctx matches 0 if score #b27 ch_ctx matches 0 if score #b34 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 48 if score #b20 ch_ctx matches 0 if score #b27 ch_ctx matches 0 if score #b34 ch_ctx matches 0 if score #b41 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
