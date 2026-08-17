scoreboard players add @s lh_timer 1
execute if score @s lh_timer matches 8 run function liars_holdem:sound/final_winner
execute if score @s lh_timer matches 60.. run function liars_holdem:game/cleanup
