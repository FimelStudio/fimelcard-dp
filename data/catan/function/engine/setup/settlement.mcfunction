execute unless score #phase ca_ctx matches 1 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 0..53 run return run function catan:engine/error {id:5}
execute unless score #settlements_left ca_ctx matches 1.. run return run function catan:engine/error {id:7}
function catan:engine/legal/vertex with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:5}
function catan:engine/build/place_v with storage catan:engine request
data modify storage catan:engine state.setup_vertex set from storage catan:engine request.target
data modify storage catan:engine state.phase set value 2
execute if score #setup_step ca_ctx >= #n ca_ctx run function catan:engine/setup/resources with storage catan:engine request
scoreboard players set #ok ca_ctx 1
