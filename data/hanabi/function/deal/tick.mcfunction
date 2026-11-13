# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s hb_phase matches 1 run return run function hanabi:deal/intro_tick
execute if score @s hb_phase matches 2 run return run function hanabi:deal/cards_tick
execute if score @s hb_phase matches 3 run return run function hanabi:deal/outro_tick

