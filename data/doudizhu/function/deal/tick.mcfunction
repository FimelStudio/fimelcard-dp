scoreboard players add @s dd_timer 1
execute if score @s dd_timer matches 1 run function cardtable:animation/deal/box/grow
execute if score @s dd_timer matches 12..62 run function doudizhu:deal/visual
execute if score @s dd_timer matches 63 run function cardtable:animation/deal/box/shrink
execute if score @s dd_timer matches 74 run function doudizhu:deal/complete
