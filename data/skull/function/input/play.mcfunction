# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s sk_state matches 1 if entity @a[tag=sk.actor,scores={sk_done=0}] run return run function skull:round/play_card with storage skull:io action
execute if score @s sk_state matches 2 if score @s sk_turn = #actor_seat sk_ctx run return run function skull:round/play_card with storage skull:io action
