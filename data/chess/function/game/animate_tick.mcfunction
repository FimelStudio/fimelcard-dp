scoreboard players remove @s ch_timer 1
execute if score @s ch_timer matches ..0 run function chess:game/animation_done
