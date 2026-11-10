$data modify storage magical_athlete:visual name_pose set value {x:$(x),y:$(y),z:$(z),duration:$(duration),text_scale:0.14}
$execute if predicate {condition:"minecraft:value_check",value:$(scale),range:{max:0.0011}} run data modify storage magical_athlete:visual name_pose.text_scale set value 0.001
scoreboard players set #name_y ma_ctx 0
execute store result score #name_y ma_ctx run data get storage magical_athlete:visual name_pose.y 1000000
$data modify storage magical_athlete:visual name_scale set value $(scale)
execute store result score #name_height ma_ctx run data get storage magical_athlete:visual name_scale 1125000
scoreboard players operation #name_y ma_ctx += #name_height ma_ctx
scoreboard players add #name_y ma_ctx 45000
execute store result storage magical_athlete:visual name_pose.y double 0.000001 run scoreboard players get #name_y ma_ctx
function magical_athlete:visual/name_pose_apply with storage magical_athlete:visual name_pose
