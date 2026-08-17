function hanabi:reward/deck/create_one
scoreboard players remove #reward_copies hb_ctx 1
execute if score #reward_copies hb_ctx matches 1.. run function hanabi:reward/deck/create_copies
