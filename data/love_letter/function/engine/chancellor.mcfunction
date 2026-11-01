execute unless data entity @s data.love_letter.deck[0] run return run function love_letter:engine/done
data modify entity @s data.ll_buffer set value []
execute store result storage love_letter:runtime card int 1 run scoreboard players get @e[tag=ll.engine_actor,limit=1] ll_hand
data modify entity @s data.ll_buffer append from storage love_letter:runtime card
function love_letter:engine/buffer_draw
execute if data entity @s data.love_letter.deck[0] run function love_letter:engine/buffer_draw
scoreboard players set @s ll_phase 4
function love_letter:game/await_choice
