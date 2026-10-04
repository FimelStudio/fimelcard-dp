scoreboard players set @s lh_timer 0
scoreboard players add @s lh_show_seat 1
execute if score @s lh_show_seat matches 1 run function liars_holdem:showdown/reveal_seat {seat:1}
execute if score @s lh_show_seat matches 2 run function liars_holdem:showdown/reveal_seat {seat:2}
execute if score @s lh_show_seat matches 3 run function liars_holdem:showdown/reveal_seat {seat:3}
execute if score @s lh_show_seat matches 4 run function liars_holdem:showdown/reveal_seat {seat:4}
execute if score @s lh_show_seat matches 5 run function liars_holdem:showdown/reveal_seat {seat:5}
execute if score @s lh_show_seat matches 6 run function liars_holdem:showdown/reveal_seat {seat:6}
execute if score @s lh_show_seat matches 7 run function liars_holdem:showdown/reveal_seat {seat:7}
execute if score @s lh_show_seat matches 8 run function liars_holdem:showdown/reveal_seat {seat:8}
execute if score @s lh_show_seat > @s ct_capacity run function liars_holdem:showdown/show_ranking
