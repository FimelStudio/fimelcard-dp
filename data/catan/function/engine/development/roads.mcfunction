execute unless score #roads_left ca_ctx matches 1.. run return run function catan:engine/error {id:7}
data modify storage catan:engine state.phase set value 8
data modify storage catan:engine state.free_left set value 2
execute if score #roads_left ca_ctx matches 1 run data modify storage catan:engine state.free_left set value 1
scoreboard players set #ok ca_ctx 1
