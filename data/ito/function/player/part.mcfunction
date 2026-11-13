tag @s add it.part
scoreboard players operation @s ct_id = #table it_ctx
scoreboard players operation @s it_seat = #join_seat it_ctx
scoreboard players operation @s it_order = #order it_ctx
data modify entity @s data.name set from storage ito:name resolved
