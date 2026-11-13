execute unless score #phase ca_ctx matches 8 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
data modify storage catan:engine state.free_left set value 0
data modify storage catan:engine state.phase set from storage catan:engine state.dev_return
scoreboard players set #ok ca_ctx 1
