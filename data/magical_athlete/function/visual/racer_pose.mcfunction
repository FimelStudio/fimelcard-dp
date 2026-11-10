$data modify storage magical_athlete:visual draw_pose set value {x:$(x),y:$(y),z:$(z),scale:$(scale),duration:$(duration)}
function magical_athlete:visual/racer_pose_apply with storage magical_athlete:visual draw_pose
scoreboard players operation #name_table ma_ctx = @s ct_id
scoreboard players operation #name_index ma_ctx = @s ma_vid
execute as @e[tag=ma.racer_name] if score @s ct_id = #name_table ma_ctx if score @s ma_vid = #name_index ma_ctx run function magical_athlete:visual/name_pose with storage magical_athlete:visual draw_pose
