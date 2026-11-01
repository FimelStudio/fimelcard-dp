scoreboard players add @s gd_v_age 1
execute if data entity @s data.path[0] run data modify entity @s transformation.translation set from entity @s data.path[0]
execute if data entity @s data.path[0] run data merge entity @s {start_interpolation:0}
data remove entity @s data.path[0]
execute if score @s gd_v_age < @s gd_v_life run return 0
execute unless entity @s[tag=gd.playing] run return run kill @s
tag @s remove gd.fx
tag @s remove gd.playing
data remove entity @s data.path
