scoreboard players operation #table ma_ctx = @s ct_id
execute as @e[tag=ma.direct] if score @s ct_id = #table ma_ctx run kill @s
function magical_athlete:visual/context
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ct_id
execute store result storage magical_athlete:direct epoch int 1 run scoreboard players get @s ma_epoch
execute if score @s ma_state matches 1 run function magical_athlete:direct/pool_spawn
execute if score @s ma_state matches 3 run function magical_athlete:direct/racer_hits
