scoreboard players add @s hb_timer 1
execute if score @s hb_timer matches 10 run function cardtable:animation/deal/box/clear
execute if score @s hb_timer matches 12.. run function hanabi:deal/complete

