# Controller at table center. Do not pull players back merely because they dismounted.
execute if entity @s[tag=ct.layout_busy] run return 0
execute unless loaded ~-3 ~ ~-3 run return 0
execute unless loaded ~3 ~ ~-3 run return 0
execute unless loaded ~-3 ~ ~3 run return 0
execute unless loaded ~3 ~ ~3 run return 0
function cardtable:chairs/layout/normalize
execute unless score @s ct_clmask = #chair_mask ct_ctx run return run function cardtable:chairs/layout/reposition
execute unless score @s ct_clver matches 1 run return run function cardtable:chairs/layout/reposition
scoreboard players operation #seat_owner ct_ctx = @s ct_id
execute unless score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure4
execute if score @s ct_capacity matches 8 run function cardtable:chairs/layout/ensure8
