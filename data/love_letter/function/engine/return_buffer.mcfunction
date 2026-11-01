execute if data entity @s data.ll_buffer[0] run data modify entity @s data.love_letter.deck append from entity @s data.ll_buffer[0]
data modify entity @s data.ll_buffer set value []
function love_letter:engine/done
