# “第x局”过场固定两秒
scoreboard players add @s lh_timer 1
execute if score @s lh_timer matches 40.. run function liars_holdem:transition/cleanup
execute if score @s lh_timer matches 40.. run function liars_holdem:deal/start
