data modify storage love_letter:visual seat set from storage love_letter:visual eliminated[0]
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/eliminated_at with storage love_letter:visual seat_data
data remove storage love_letter:visual eliminated[0]
execute if data storage love_letter:visual eliminated[0] run function love_letter:visual/eliminated
