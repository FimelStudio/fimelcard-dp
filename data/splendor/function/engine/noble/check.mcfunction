data modify storage splendor:engine state.eligible set value []
function splendor:engine/noble/check_slot {slot:0}
function splendor:engine/noble/check_slot {slot:1}
function splendor:engine/noble/check_slot {slot:2}
function splendor:engine/noble/check_slot {slot:3}
function splendor:engine/noble/check_slot {slot:4}
execute store result score #eligible sp_ctx run data get storage splendor:engine state.eligible
execute if score #eligible sp_ctx matches 2.. run data modify storage splendor:engine state.phase set value 3
execute if score #eligible sp_ctx matches 2.. run return 1
execute if score #eligible sp_ctx matches 1 store result storage splendor:engine request.noble_slot int 1 run data get storage splendor:engine state.eligible[0]
execute if score #eligible sp_ctx matches 1 run function splendor:engine/noble/award with storage splendor:engine request
function splendor:engine/advance
