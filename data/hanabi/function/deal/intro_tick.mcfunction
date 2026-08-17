scoreboard players add @s hb_timer 1
execute if score @s hb_timer matches 1 run function cardtable:animation/deal/box/grow
execute if score @s hb_timer matches 11.. run scoreboard players set @s hb_phase 2
execute if score @s hb_timer matches 11.. run scoreboard players set @s hb_timer 0

