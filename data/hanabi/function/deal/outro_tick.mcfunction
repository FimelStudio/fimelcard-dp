# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s hb_timer 1
execute if score @s hb_timer matches 10 run function cardtable:animation/deal/box/clear
execute if score @s hb_timer matches 12.. run function hanabi:deal/complete

