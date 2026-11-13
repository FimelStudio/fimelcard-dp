scoreboard players operation #vis_sq ch_ctx = @s ch_sq
execute store result storage chess:visual duration int 1 run scoreboard players get #vis_duration ch_ctx
execute if score #vis_cap ch_ctx matches 4 run data modify storage chess:visual scale set value 0.39
execute if score #vis_cap ch_ctx matches 4 run data modify storage chess:visual lift set value 0.195
execute if score #vis_cap ch_ctx matches 8 run data modify storage chess:visual scale set value 0.53
execute if score #vis_cap ch_ctx matches 8 run data modify storage chess:visual lift set value 0.265
function chess:visual/resolve_square
data modify storage chess:visual x set from storage chess:visual coord.x
data modify storage chess:visual z set from storage chess:visual coord.z
function chess:visual/man_rotation
function chess:visual/set_pose with storage chess:visual
