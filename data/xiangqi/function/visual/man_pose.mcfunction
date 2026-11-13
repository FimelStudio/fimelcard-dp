scoreboard players operation #vis_sq xq_ctx = @s xq_sq
execute store result storage xiangqi:visual duration int 1 run scoreboard players get #vis_duration xq_ctx
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual scale set value 0.231
execute if score #vis_cap xq_ctx matches 4 run data modify storage xiangqi:visual lift set value 0.1155
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual scale set value 0.317
execute if score #vis_cap xq_ctx matches 8 run data modify storage xiangqi:visual lift set value 0.1585
function xiangqi:visual/resolve_square
data modify storage xiangqi:visual x set from storage xiangqi:visual coord.x
data modify storage xiangqi:visual z set from storage xiangqi:visual coord.z
function xiangqi:visual/man_rotation
function xiangqi:visual/set_pose with storage xiangqi:visual
