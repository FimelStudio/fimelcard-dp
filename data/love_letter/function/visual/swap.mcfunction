data modify storage love_letter:visual saved_actor set from storage love_letter:visual seat
data modify storage love_letter:visual saved_target set from storage love_letter:visual target
function love_letter:visual/swap_one
data modify storage love_letter:visual seat set from storage love_letter:visual saved_target
data modify storage love_letter:visual target set from storage love_letter:visual saved_actor
function love_letter:visual/swap_one
data modify storage love_letter:visual seat set from storage love_letter:visual saved_actor
data modify storage love_letter:visual target set from storage love_letter:visual saved_target
