$scoreboard players set #vis_seat ll_ctx $(seat)
scoreboard players remove #vis_seat ll_ctx 1
execute store result storage love_letter:visual seat_index int 1 run scoreboard players get #vis_seat ll_ctx
function love_letter:visual/seat with storage love_letter:visual
