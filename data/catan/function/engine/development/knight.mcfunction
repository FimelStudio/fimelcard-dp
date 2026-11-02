scoreboard players add #knights ca_ctx 1
function catan:engine/development/save_knights with storage catan:engine request
data modify storage catan:engine state.robber_return set from storage catan:engine state.dev_return
data modify storage catan:engine state.phase set value 6
scoreboard players set #ok ca_ctx 1
