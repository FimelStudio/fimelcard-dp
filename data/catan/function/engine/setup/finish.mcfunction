data modify storage catan:engine state.turn set value 1
data modify storage catan:engine state.setup_vertex set value -1
scoreboard players set #resume ca_ctx 3
function catan:engine/job/start
scoreboard players set #ok ca_ctx 1
