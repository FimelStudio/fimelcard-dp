execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless data storage catan:engine state.dev_deck[-1] run return run function catan:engine/error {id:7}
scoreboard players set #valid ca_ctx 0
function catan:engine/cost/development
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:6}
execute store result storage catan:engine request.dev int 1 run data get storage catan:engine state.dev_deck[-1]
data remove storage catan:engine state.dev_deck[-1]
function catan:engine/development/add_fresh with storage catan:engine request
function catan:engine/save_dev with storage catan:engine request
scoreboard players set #ok ca_ctx 1
