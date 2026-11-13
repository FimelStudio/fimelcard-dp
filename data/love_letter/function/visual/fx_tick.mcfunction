# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless data entity @s data.ll_frames[0] run return run kill @s
data merge entity @s {start_interpolation:0,interpolation_duration:1}
data modify entity @s transformation.translation set from entity @s data.ll_frames[0]
data remove entity @s data.ll_frames[0]
