data modify storage magical_athlete:direct old_x set from storage magical_athlete:direct x
execute store result score #pool_z ma_ctx run data get storage magical_athlete:direct z 1000000
execute store result storage magical_athlete:direct x double -0.000001 run scoreboard players get #pool_z ma_ctx
data modify storage magical_athlete:direct z set from storage magical_athlete:direct old_x
