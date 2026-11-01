function weiqi:visual/tick
scoreboard players remove @s go_timer 1
execute if score @s go_timer matches ..0 run function weiqi:game/animation_done
