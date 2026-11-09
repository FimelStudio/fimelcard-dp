function love_letter:visual/role_actor with storage love_letter:visual seat_data
execute store result score #vis_target ll_ctx run data get storage love_letter:visual target
execute unless score #vis_target ll_ctx matches 1..8 run return 0
data modify storage love_letter:visual saved_seat set from storage love_letter:visual seat
data modify storage love_letter:visual seat set from storage love_letter:visual target
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/role_target with storage love_letter:visual seat_data
data modify storage love_letter:visual seat set from storage love_letter:visual saved_seat
function love_letter:visual/event_seat with storage love_letter:visual
