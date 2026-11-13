execute unless score @s ll_state matches 2 run return 0
execute unless score @s ll_anim matches 0 run return 0
execute if score @s ll_phase matches 1 run return run function love_letter:engine/auto_play
execute if score @s ll_phase matches 2 run return run function love_letter:engine/auto_target
execute if score @s ll_phase matches 3 run return run function love_letter:engine/auto_guess
execute if score @s ll_phase matches 4 run return run function love_letter:engine/auto_keep
execute if score @s ll_phase matches 5 run return run function love_letter:engine/auto_bottom
