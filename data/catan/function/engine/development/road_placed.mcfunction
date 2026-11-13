execute store result score #free_left ca_ctx run data get storage catan:engine state.free_left
scoreboard players remove #free_left ca_ctx 1
execute store result storage catan:engine state.free_left int 1 run scoreboard players get #free_left ca_ctx
execute store result score #resume ca_ctx run data get storage catan:engine state.dev_return
execute if score #free_left ca_ctx matches 1.. if score #roads_left ca_ctx matches 1.. run scoreboard players set #resume ca_ctx 8
