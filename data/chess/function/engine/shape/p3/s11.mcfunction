execute if score #to ch_ctx matches 2 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 4 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 18 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 20 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 25 if score #b18 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 29 if score #b20 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 32 if score #b18 ch_ctx matches 0 if score #b25 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 38 if score #b20 ch_ctx matches 0 if score #b29 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
execute if score #to ch_ctx matches 47 if score #b20 ch_ctx matches 0 if score #b29 ch_ctx matches 0 if score #b38 ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1
