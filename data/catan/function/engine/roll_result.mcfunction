execute store result storage catan:engine state.dice[0] int 1 run scoreboard players get #d1 ca_ctx
execute store result storage catan:engine state.dice[1] int 1 run scoreboard players get #d2 ca_ctx
scoreboard players operation #sum ca_ctx = #d1 ca_ctx
scoreboard players operation #sum ca_ctx += #d2 ca_ctx
execute if score #sum ca_ctx matches 7 run return run function catan:engine/seven
data modify storage catan:engine state.phase set value 4
function catan:engine/production
