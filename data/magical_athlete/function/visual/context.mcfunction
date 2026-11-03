scoreboard players operation #vis_table ma_ctx = @s ct_id
execute store result storage magical_athlete:visual cap int 1 run scoreboard players get @s ct_capacity
execute store result storage magical_athlete:visual orient int 1 run scoreboard players get @s ma_orient
function magical_athlete:visual/layout with storage magical_athlete:visual
