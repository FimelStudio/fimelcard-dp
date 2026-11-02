execute unless score #phase ca_ctx matches 2 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 0..71 run return run function catan:engine/error {id:5}
execute unless score #roads_left ca_ctx matches 1.. run return run function catan:engine/error {id:7}
function catan:engine/legal/edge with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:5}
function catan:engine/build/place_e with storage catan:engine request
scoreboard players add #setup_step ca_ctx 1
execute store result storage catan:engine state.setup_step int 1 run scoreboard players get #setup_step ca_ctx
scoreboard players operation #twon ca_ctx = #n ca_ctx
scoreboard players operation #twon ca_ctx *= #two ca_ctx
execute if score #setup_step ca_ctx >= #twon ca_ctx run return run function catan:engine/setup/finish
scoreboard players operation #turn ca_ctx = #setup_step ca_ctx
execute if score #setup_step ca_ctx < #n ca_ctx run scoreboard players add #turn ca_ctx 1
execute if score #setup_step ca_ctx >= #n ca_ctx run scoreboard players operation #turn ca_ctx = #twon ca_ctx
execute if score #setup_step ca_ctx >= #n ca_ctx run scoreboard players operation #turn ca_ctx -= #setup_step ca_ctx
execute store result storage catan:engine state.turn int 1 run scoreboard players get #turn ca_ctx
data modify storage catan:engine state.phase set value 1
data modify storage catan:engine state.setup_vertex set value -1
scoreboard players set #ok ca_ctx 1
