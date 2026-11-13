execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
function catan:engine/trade/read
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:11}
execute unless score #actor ca_ctx = #trade_from ca_ctx unless score #actor ca_ctx = #trade_to ca_ctx run return run function catan:engine/error {id:11}
data remove storage catan:engine state.trade
scoreboard players set #ok ca_ctx 1
