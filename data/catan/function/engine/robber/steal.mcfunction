execute unless score #phase ca_ctx matches 7 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 1..4 run return run function catan:engine/error {id:5}
execute if score #target ca_ctx > #n ca_ctx run return run function catan:engine/error {id:5}
data modify storage catan:engine rng.hex set from storage catan:engine state.robber
function catan:engine/robber/scan with storage catan:engine rng
function catan:engine/robber/check_victim with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:5}
function catan:engine/load_other with storage catan:engine request
scoreboard players set #total ca_ctx 0
scoreboard players operation #total ca_ctx += #o0 ca_ctx
scoreboard players operation #total ca_ctx += #o1 ca_ctx
scoreboard players operation #total ca_ctx += #o2 ca_ctx
scoreboard players operation #total ca_ctx += #o3 ca_ctx
scoreboard players operation #total ca_ctx += #o4 ca_ctx
data modify storage catan:engine state.last.stolen set value 0
execute if score #total ca_ctx matches 1.. run function catan:engine/robber/draw
function catan:engine/robber/return
scoreboard players set #ok ca_ctx 1
