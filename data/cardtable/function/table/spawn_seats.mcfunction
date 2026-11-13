function cardtable:chairs/layout/normalize
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure4
execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure8
execute if score @s ct_capacity matches 8 run function cardtable:table/spawn_chairs8
data merge entity @s {data:{cardtable:{chairs_version:1}}}
