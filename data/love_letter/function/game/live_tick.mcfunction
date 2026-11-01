execute if score @s ll_anim matches 1.. run return run function love_letter:game/anim_tick
execute if score @s ll_time_setting matches 0 run return 0
execute if score @s ll_clock matches 1.. run scoreboard players remove @s ll_clock 1
execute if score @s ll_clock matches 0 run function love_letter:game/timeout
