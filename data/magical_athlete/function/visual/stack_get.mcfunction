$data modify storage magical_athlete:visual offset set from storage magical_athlete:visual layout.groups[$(count)][$(rank)]
data modify storage magical_athlete:visual pose.scale set from storage magical_athlete:visual offset.scale
execute store result score #stack_base ma_ctx run data get storage magical_athlete:visual pose.x 1000000
execute store result score #stack_delta ma_ctx run data get storage magical_athlete:visual offset.dx 1000000
scoreboard players operation #stack_base ma_ctx += #stack_delta ma_ctx
execute store result storage magical_athlete:visual pose.x double 0.000001 run scoreboard players get #stack_base ma_ctx
execute store result score #stack_base ma_ctx run data get storage magical_athlete:visual pose.z 1000000
execute store result score #stack_delta ma_ctx run data get storage magical_athlete:visual offset.dz 1000000
scoreboard players operation #stack_base ma_ctx += #stack_delta ma_ctx
execute store result storage magical_athlete:visual pose.z double 0.000001 run scoreboard players get #stack_base ma_ctx
