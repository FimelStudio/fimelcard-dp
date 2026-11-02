execute unless score #phase ca_ctx matches 3 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute store result score #d1 ca_ctx run random value 1..6 catan:play
execute store result score #d2 ca_ctx run random value 1..6 catan:play
function catan:engine/roll_result
scoreboard players set #ok ca_ctx 1
