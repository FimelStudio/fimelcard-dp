# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s hb_timer 1
execute if score @s hb_storm matches 0 if score @s hb_timer matches 80.. run function hanabi:game/cleanup
execute if score @s hb_storm matches 1 if score @s hb_timer matches 110.. run function hanabi:game/cleanup
