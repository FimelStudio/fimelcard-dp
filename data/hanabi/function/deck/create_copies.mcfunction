function hanabi:deck/create_one
scoreboard players remove #deck_copies hb_ctx 1
execute if score #deck_copies hb_ctx matches 1.. run function hanabi:deck/create_copies
