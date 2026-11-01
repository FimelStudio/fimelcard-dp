scoreboard players add @s go_timer 1
execute if score @s go_timer matches 15.. run scoreboard players set @s go_timer 0
execute if score @s go_timer matches 0 run function weiqi:game/review_advance
