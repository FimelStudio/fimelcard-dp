execute unless score #phase sp_ctx matches 3 run return run function splendor:engine/error {id:5}
execute unless score #target sp_ctx matches 0..4 run return run function splendor:engine/error {id:8}
scoreboard players set #valid sp_ctx 0
function splendor:engine/noble/select_check with storage splendor:engine request
execute unless score #valid sp_ctx matches 1 run return run function splendor:engine/error {id:14}
data modify storage splendor:engine request.noble_slot set from storage splendor:engine request.target
function splendor:engine/noble/award with storage splendor:engine request
function splendor:engine/advance
scoreboard players set #ok sp_ctx 1
