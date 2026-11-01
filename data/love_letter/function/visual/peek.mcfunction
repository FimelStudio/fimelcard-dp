data modify storage love_letter:visual saved_seat set from storage love_letter:visual seat
data modify storage love_letter:visual seat set from storage love_letter:visual target
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/peek_at with storage love_letter:visual seat_data
data modify storage love_letter:visual seat set from storage love_letter:visual saved_seat
