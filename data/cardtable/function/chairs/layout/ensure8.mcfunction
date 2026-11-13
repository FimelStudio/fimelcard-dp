scoreboard players set #new_seat ct_ctx 1
execute if score @s ct_c1 matches 1 if score @s ct_c2 matches 1 positioned ~-1 ~0.32 ~-2.5 run function cardtable:seat/ensure_one
execute if score @s ct_c1 matches 1 unless score @s ct_c2 matches 1 positioned ~0 ~0.32 ~-2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 2
execute if score @s ct_c2 matches 1 if score @s ct_c1 matches 1 positioned ~1 ~0.32 ~-2.5 run function cardtable:seat/ensure_one
execute if score @s ct_c2 matches 1 unless score @s ct_c1 matches 1 positioned ~0 ~0.32 ~-2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 3
execute if score @s ct_c3 matches 1 if score @s ct_c4 matches 1 positioned ~2.5 ~0.32 ~-1 run function cardtable:seat/ensure_one
execute if score @s ct_c3 matches 1 unless score @s ct_c4 matches 1 positioned ~2.5 ~0.32 ~0 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 4
execute if score @s ct_c4 matches 1 if score @s ct_c3 matches 1 positioned ~2.5 ~0.32 ~1 run function cardtable:seat/ensure_one
execute if score @s ct_c4 matches 1 unless score @s ct_c3 matches 1 positioned ~2.5 ~0.32 ~0 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 5
execute if score @s ct_c5 matches 1 if score @s ct_c6 matches 1 positioned ~1 ~0.32 ~2.5 run function cardtable:seat/ensure_one
execute if score @s ct_c5 matches 1 unless score @s ct_c6 matches 1 positioned ~0 ~0.32 ~2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 6
execute if score @s ct_c6 matches 1 if score @s ct_c5 matches 1 positioned ~-1 ~0.32 ~2.5 run function cardtable:seat/ensure_one
execute if score @s ct_c6 matches 1 unless score @s ct_c5 matches 1 positioned ~0 ~0.32 ~2.5 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 7
execute if score @s ct_c7 matches 1 if score @s ct_c8 matches 1 positioned ~-2.5 ~0.32 ~1 run function cardtable:seat/ensure_one
execute if score @s ct_c7 matches 1 unless score @s ct_c8 matches 1 positioned ~-2.5 ~0.32 ~0 run function cardtable:seat/ensure_one
scoreboard players set #new_seat ct_ctx 8
execute if score @s ct_c8 matches 1 if score @s ct_c7 matches 1 positioned ~-2.5 ~0.32 ~-1 run function cardtable:seat/ensure_one
execute if score @s ct_c8 matches 1 unless score @s ct_c7 matches 1 positioned ~-2.5 ~0.32 ~0 run function cardtable:seat/ensure_one
