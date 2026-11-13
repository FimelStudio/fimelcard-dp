execute unless score #a ca_ctx matches 0..4 run return run function catan:engine/error {id:5}
execute unless score #b ca_ctx matches 0..4 run return run function catan:engine/error {id:5}
function catan:engine/development/invention_take with storage catan:engine request
execute unless score #valid ca_ctx matches 1 run return run function catan:engine/error {id:6}
function catan:engine/save_resources with storage catan:engine request
function catan:engine/save_bank
scoreboard players set #ok ca_ctx 1
