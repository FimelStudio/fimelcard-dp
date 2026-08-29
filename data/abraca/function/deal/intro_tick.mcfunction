scoreboard players add @s ab_timer 1
execute if score @s ab_timer matches 1 run function cardtable:animation/deal/box/grow
execute if score @s ab_timer matches 11.. run scoreboard players set @s ab_phase 2
execute if score @s ab_timer matches 11.. run scoreboard players set @s ab_timer 0
