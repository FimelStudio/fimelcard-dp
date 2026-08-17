scoreboard players add @s lh_timer 1
execute if score @s lh_timer matches 15.. if score @s lh_state matches 6 run return run function liars_holdem:stage/start_second
execute if score @s lh_timer matches 15.. if score @s lh_state matches 8 run return run function liars_holdem:stage/start_third
execute if score @s lh_timer matches 15.. if score @s lh_state matches 10 if score @s lh_auto matches 1 run return run function liars_holdem:showdown/start
execute if score @s lh_timer matches 15.. if score @s lh_state matches 10 run return run function liars_holdem:stage/start_final
