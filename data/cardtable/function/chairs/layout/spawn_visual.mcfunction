execute unless score @s ct_chairs matches 1..8 run function cardtable:chairs/layout/normalize
scoreboard players operation #seat_owner ct_ctx = @s ct_id
scoreboard players operation #skin_table ct_ctx = @s ct_id
execute if score @s ct_skin matches 0 if entity @s[tag=ct.no_structure] run return 0
execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/visual4
execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/visual8
