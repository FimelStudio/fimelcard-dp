execute unless score #phase ca_ctx matches 4 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
data remove storage catan:engine state.trade
scoreboard players add #turn ca_ctx 1
execute if score #turn ca_ctx > #n ca_ctx run scoreboard players set #turn ca_ctx 1
execute store result storage catan:engine state.turn int 1 run scoreboard players get #turn ca_ctx
data modify storage catan:engine state.phase set value 3
data modify storage catan:engine state.used_dev set value 0
execute store result storage catan:engine tmp.actor int 1 run scoreboard players get #turn ca_ctx
function catan:engine/age_cards with storage catan:engine tmp
scoreboard players set #ok ca_ctx 1
