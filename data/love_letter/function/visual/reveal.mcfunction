execute store result storage love_letter:visual card int 1 run data get entity @s data.ll_reveal
function love_letter:visual/resolve_model
data modify storage love_letter:visual seat_data.model set from storage love_letter:visual model
data modify storage love_letter:visual seat_data.x set from storage love_letter:visual seat_data.reveal_x
data modify storage love_letter:visual seat_data.z set from storage love_letter:visual seat_data.reveal_z
function love_letter:visual/reveal_at with storage love_letter:visual seat_data
