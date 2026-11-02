execute unless score #phase ca_ctx matches 6 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 0..18 run return run function catan:engine/error {id:5}
execute if score #target ca_ctx = #robber ca_ctx run return run function catan:engine/error {id:5}
data modify storage catan:engine state.robber set from storage catan:engine request.target
data modify storage catan:engine rng.hex set from storage catan:engine request.target
function catan:engine/robber/scan with storage catan:engine rng
data modify storage catan:engine state.eligible set value []
execute if score #victim1 ca_ctx matches 1 run data modify storage catan:engine state.eligible append value 1
execute if score #victim2 ca_ctx matches 1 run data modify storage catan:engine state.eligible append value 2
execute if score #victim3 ca_ctx matches 1 run data modify storage catan:engine state.eligible append value 3
execute if score #victim4 ca_ctx matches 1 run data modify storage catan:engine state.eligible append value 4
data modify storage catan:engine state.phase set value 7
execute unless data storage catan:engine state.eligible[0] run function catan:engine/robber/return
scoreboard players set #ok ca_ctx 1
