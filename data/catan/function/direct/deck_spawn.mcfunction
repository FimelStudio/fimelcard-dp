scoreboard players operation #table ca_ctx = @s ct_id
execute as @e[tag=ca.deck_direct] if score @s ct_id = #table ca_ctx run kill @s
execute store result storage catan:direct remaining int 1 run data get entity @s data.catan.dev_deck
execute if score @s ca_orient matches 0 positioned ~ ~1.08 ~-1.5 run function catan:direct/deck_at
execute if score @s ca_orient matches 1 positioned ~1.5 ~1.08 ~ run function catan:direct/deck_at
