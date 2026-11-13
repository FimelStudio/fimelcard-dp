function love_letter:engine/private
data modify entity @s data.ll_private.kind set value "king"
scoreboard players operation #swap ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_hand
scoreboard players operation @e[tag=ll.engine_actor,limit=1] ll_hand = @e[tag=ll.engine_target,limit=1] ll_hand
scoreboard players operation @e[tag=ll.engine_target,limit=1] ll_hand = #swap ll_ctx
function love_letter:engine/done
