# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s ab_timer 1
execute if score @s ab_timer matches 1 run function cardtable:animation/deal/box/grow
execute if score @s ab_timer matches 11.. run scoreboard players set @s ab_phase 2
execute if score @s ab_timer matches 11.. run scoreboard players set @s ab_timer 0
