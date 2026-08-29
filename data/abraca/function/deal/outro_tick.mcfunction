scoreboard players add @s ab_timer 1
execute if score @s ab_timer matches 10 run function cardtable:animation/deal/box/clear
execute if score @s ab_timer matches 12.. run function abraca:deal/complete
