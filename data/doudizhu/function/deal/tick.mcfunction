# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s dd_lane matches 2 run return 0
scoreboard players add @s dd_timer 1
execute if score @s dd_timer matches 1 run function cardtable:animation/deal/box/grow
execute if score @s dd_timer matches 12..62 if score @s dd_lane matches 1 run function doudizhu:duplicate/deal_visual
execute if score @s dd_timer matches 12..62 unless score @s dd_lane matches 1 run function doudizhu:deal/visual
execute if score @s dd_timer matches 63 run function cardtable:animation/deal/box/shrink
execute if score @s dd_timer matches 74 if score @s dd_lane matches 1 run function doudizhu:duplicate/deal_complete_other
execute if score @s dd_timer matches 74 run function doudizhu:deal/complete
