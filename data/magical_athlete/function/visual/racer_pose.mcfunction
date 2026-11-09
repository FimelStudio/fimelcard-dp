$data modify storage magical_athlete:visual draw_pose set value {x:$(x),y:$(y),z:$(z),scale:$(scale),duration:$(duration)}
execute store result score #racer_y ma_ctx run data get storage magical_athlete:visual draw_pose.y 1000000
execute store result score #racer_lift ma_ctx run data get storage magical_athlete:visual draw_pose.scale 500000
scoreboard players operation #racer_y ma_ctx += #racer_lift ma_ctx
execute store result storage magical_athlete:visual draw_pose.y double 0.000001 run scoreboard players get #racer_y ma_ctx
function magical_athlete:visual/racer_pose_apply with storage magical_athlete:visual draw_pose
