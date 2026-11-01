scoreboard players remove @s ll_anim 1
execute if score @s ll_anim matches 0 run function love_letter:ui/refresh
