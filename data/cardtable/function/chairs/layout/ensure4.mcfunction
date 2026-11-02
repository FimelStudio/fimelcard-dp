scoreboard players set #new_seat ct_ctx 1
execute if score @s ct_c1 matches 1 positioned ~0 ~0.32 ~-2 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 2
execute if score @s ct_c2 matches 1 positioned ~2 ~0.32 ~0 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 3
execute if score @s ct_c3 matches 1 positioned ~0 ~0.32 ~2 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 4
execute if score @s ct_c4 matches 1 positioned ~-2 ~0.32 ~0 run function cardtable:seat/ensure_one
