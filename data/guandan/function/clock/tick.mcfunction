execute if score @s gd_anim matches 1.. run return run function guandan:clock/animation
execute if score @s gd_limit matches 0 run return 0
execute if score @s gd_clock matches 1.. run scoreboard players remove @s gd_clock 1
execute if score @s gd_clock matches 0 run function guandan:clock/timeout
