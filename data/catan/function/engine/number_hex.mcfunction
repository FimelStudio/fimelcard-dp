$execute store result score #terrain ca_ctx run data get storage catan:engine state.terrain[$(hex)]
$execute if score #terrain ca_ctx matches 5 run data modify storage catan:engine state.robber set value $(hex)
execute if score #terrain ca_ctx matches 5 run return 0
$data modify storage catan:engine rng.hex set value $(hex)
execute store result storage catan:engine rng.pick int 1 run scoreboard players get #number ca_ctx
function catan:engine/set_number with storage catan:engine rng
scoreboard players add #number ca_ctx 1
