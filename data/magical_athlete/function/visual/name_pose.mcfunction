$data modify storage magical_athlete:visual name_pose set value {x:$(x),y:$(y),z:$(z),duration:$(duration),text_scale:0.5}
execute store result storage magical_athlete:visual name_pose.table int 1 run scoreboard players get @s ct_id
execute store result storage magical_athlete:visual name_pose.index int 1 run scoreboard players get @s ma_vid
scoreboard players set #name_y ma_ctx 0
execute store result score #name_y ma_ctx run data get storage magical_athlete:visual name_pose.y 1000000
$data modify storage magical_athlete:visual name_scale set value $(scale)
execute store result score #name_size ma_ctx run data get storage magical_athlete:visual name_scale 1000000
execute if score #name_size ma_ctx matches ..160000 run data modify storage magical_athlete:visual name_pose.text_scale set value 0.3
execute if score #name_size ma_ctx matches ..1100 run data modify storage magical_athlete:visual name_pose.text_scale set value 0.001
execute store result score #name_height ma_ctx run data get storage magical_athlete:visual name_scale 1125000
scoreboard players operation #name_y ma_ctx += #name_height ma_ctx
scoreboard players add #name_y ma_ctx 65000
execute store result storage magical_athlete:visual name_pose.y double 0.000001 run scoreboard players get #name_y ma_ctx
function magical_athlete:visual/name_pose_apply with storage magical_athlete:visual name_pose
