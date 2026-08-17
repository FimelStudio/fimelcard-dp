scoreboard players add @s hb_timer 1
execute if score @s hb_storm matches 0 if score @s hb_timer matches 80.. run function hanabi:game/cleanup
execute if score @s hb_storm matches 1 if score @s hb_timer matches 110.. run function hanabi:game/cleanup
