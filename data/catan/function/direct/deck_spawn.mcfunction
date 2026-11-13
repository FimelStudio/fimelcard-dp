scoreboard players operation #table ca_ctx = @s ct_id
execute as @e[tag=ca.deck_direct] if score @s ct_id = #table ca_ctx run kill @s
execute store result storage catan:direct remaining int 1 run data get entity @s data.catan.dev_deck
scoreboard players operation #deck_orient ca_ctx = @s ca_orient
# The square table corners are outside the hexagonal sea frame at both sizes.
execute if score @s ct_capacity matches 4 if score @s ca_orient matches 0 positioned ~1.18 ~1.10 ~-1.18 run function catan:direct/deck_at
execute if score @s ct_capacity matches 4 if score @s ca_orient matches 1 positioned ~1.18 ~1.10 ~1.18 run function catan:direct/deck_at
execute if score @s ct_capacity matches 8 if score @s ca_orient matches 0 positioned ~1.65 ~1.10 ~-1.65 run function catan:direct/deck_at
execute if score @s ct_capacity matches 8 if score @s ca_orient matches 1 positioned ~1.65 ~1.10 ~1.65 run function catan:direct/deck_at
