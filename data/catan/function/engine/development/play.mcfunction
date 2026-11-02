execute unless score #phase ca_ctx matches 3..4 run return run function catan:engine/error {id:4}
execute unless score #actor ca_ctx = #turn ca_ctx run return run function catan:engine/error {id:4}
execute unless score #target ca_ctx matches 0..4 run return run function catan:engine/error {id:5}
execute if score #target ca_ctx matches 4 run return run function catan:engine/development/vp with storage catan:engine request
execute unless score #used_dev ca_ctx matches 0 run return run function catan:engine/error {id:10}
function catan:engine/development/take with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:10}
data modify storage catan:engine state.used_dev set value 1
execute store result storage catan:engine state.dev_return int 1 run scoreboard players get #phase ca_ctx
function catan:engine/save_dev with storage catan:engine request
execute if score #target ca_ctx matches 0 run return run function catan:engine/development/knight
execute if score #target ca_ctx matches 1 run return run function catan:engine/development/roads
execute if score #target ca_ctx matches 2 run return run function catan:engine/development/monopoly
execute if score #target ca_ctx matches 3 run return run function catan:engine/development/invention
return run function catan:engine/error {id:10}
