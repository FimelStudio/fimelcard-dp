scoreboard players add @s fca_timer_total 1

execute if score @s fca_timer matches 0 at @s run return run function fimel_anim_text:positional/animation/process/marker/pos

scoreboard players remove @s fca_timer 1