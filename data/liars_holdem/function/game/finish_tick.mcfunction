# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s lh_timer 1
execute if score @s lh_timer matches 8 run function liars_holdem:sound/final_winner
execute if score @s lh_timer matches 60.. run function liars_holdem:game/cleanup
