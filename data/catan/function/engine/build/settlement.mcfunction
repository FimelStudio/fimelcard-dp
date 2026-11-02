execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 0..53 run return run function catan:engine/error {id:5}
execute unless score #settlements_left ca_ctx matches 1.. run return run function catan:engine/error {id:7}
function catan:engine/legal/vertex with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:5}
scoreboard players set #valid ca_ctx 0
function catan:engine/cost/settlement
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:6}
function catan:engine/build/place_v with storage catan:engine request
scoreboard players set #resume ca_ctx 4
function catan:engine/job/start
scoreboard players set #ok ca_ctx 1
