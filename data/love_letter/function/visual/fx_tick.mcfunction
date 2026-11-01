execute unless data entity @s data.ll_frames[0] run return run kill @s
data merge entity @s {start_interpolation:0,interpolation_duration:1}
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
