execute store result score #vis_roll ca_ctx run data get storage catan:visual roll
execute unless score #vis_roll ca_ctx matches 1..6 run data modify storage catan:visual roll set value 1
function catan:visual/dice_coordinate with storage catan:visual
function catan:visual/dice_entity with storage catan:visual
