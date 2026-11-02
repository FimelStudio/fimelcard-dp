data modify storage catan:engine node set from storage catan:engine state.job.stack[-1]
data remove storage catan:engine state.job.stack[-1]
execute store result score #node_v ca_ctx run data get storage catan:engine node.vertex
execute store result score #node_mask ca_ctx run data get storage catan:engine node.mask
execute store result score #node_length ca_ctx run data get storage catan:engine node.length
execute store result score #best ca_ctx run data get storage catan:engine state.job.best
execute store result score #jp ca_ctx run data get storage catan:engine state.job.player
execute if score #node_length ca_ctx > #best ca_ctx store result storage catan:engine state.job.best int 1 run scoreboard players get #node_length ca_ctx
function catan:engine/job/route with storage catan:engine node
