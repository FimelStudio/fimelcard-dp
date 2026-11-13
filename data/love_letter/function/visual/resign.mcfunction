function love_letter:system/context
function love_letter:visual/context
execute store result storage love_letter:visual seat int 1 run scoreboard players get #resigning ll_ctx
function love_letter:visual/event_seat with storage love_letter:visual
function love_letter:visual/eliminated_at with storage love_letter:visual seat_data
