function love_letter:engine/draw
execute store result storage love_letter:runtime card int 1 run scoreboard players get #draw ll_ctx
data modify entity @s data.love_letter.public append from storage love_letter:runtime card
