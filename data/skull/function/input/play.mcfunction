execute if score @s sk_state matches 1 if entity @a[tag=sk.actor,scores={sk_done=0}] run return run function skull:round/play_card with storage skull:io action
execute if score @s sk_state matches 2 if score @s sk_turn = #actor_seat sk_ctx run return run function skull:round/play_card with storage skull:io action
