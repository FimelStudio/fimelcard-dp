scoreboard players operation #discard ll_ctx = @e[tag=ll.engine_target,limit=1] ll_hand
scoreboard players operation #prince_card ll_ctx = #discard ll_ctx
execute store result entity @s data.love_letter.action.forced int 1 run scoreboard players get #discard ll_ctx
execute as @e[tag=ll.engine_target] run function love_letter:engine/discard
scoreboard players set @e[tag=ll.engine_target] ll_hand -1
execute if score #prince_card ll_ctx matches 9 as @e[tag=ll.engine_target] run function love_letter:engine/eliminate
execute if score #prince_card ll_ctx matches 9 run return run function love_letter:engine/done
function love_letter:engine/draw
execute if score #draw ll_ctx matches -1 run function love_letter:engine/reserve
scoreboard players operation @e[tag=ll.engine_target,limit=1] ll_hand = #draw ll_ctx
function love_letter:engine/done
