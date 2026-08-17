scoreboard players add @s lh_timer 1
execute if score @s lh_timer matches 1 run function cardtable:animation/deal/box/grow
execute if score @s lh_timer matches 11.. run scoreboard players set @s lh_phase 2
execute if score @s lh_timer matches 11.. run scoreboard players set @s lh_timer 0
