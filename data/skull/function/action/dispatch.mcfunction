execute if score @s sk_state matches 2..3 if score @s sk_turn = #actor_seat sk_ctx if score #choice sk_ctx matches 11..26 run return run function skull:auction/bid
execute if score @s sk_state matches 3 if score @s sk_turn = #actor_seat sk_ctx if score #choice sk_ctx matches 30 run return run function skull:auction/pass
execute if score @s sk_state matches 4 if score @s sk_lead = #actor_seat sk_ctx if score #choice sk_ctx matches 41..44 run return run function skull:challenge/choose
execute if score @s sk_state matches 5 if score @s sk_lead = #actor_seat sk_ctx if score #choice sk_ctx matches 51..54 run return run function skull:discard/choose
execute as @a[tag=sk.actor,limit=1] run function skull:ui/open
