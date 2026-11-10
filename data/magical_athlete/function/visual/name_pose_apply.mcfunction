$data merge entity @s {teleport_duration:$(duration),start_interpolation:0,interpolation_duration:$(duration),transformation:{translation:[0f,0f,0f],scale:[$(text_scale)f,$(text_scale)f,$(text_scale)f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f]}}
$execute at @e[tag=ma.racer,scores={ct_id=$(table),ma_vid=$(index)},limit=1] positioned ~$(x) ~$(y) ~$(z) run tp @s ~ ~ ~
