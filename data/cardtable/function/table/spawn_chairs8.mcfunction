execute if score @s ct_skin matches 1..6 run return 0
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute as @e[tag=ct.chair8] if score @s ct_id = #seat_owner ct_ctx run kill @s
function cardtable:chairs/layout/spawn_visual
