# Red lettering faces south, black lettering faces north.
execute if score #vis_orient xq_ctx matches 0 if score @s xq_piece matches 1.. run data modify storage xiangqi:visual rotation set value {qy:0.0,qw:1}
execute if score #vis_orient xq_ctx matches 0 if score @s xq_piece matches ..-1 run data modify storage xiangqi:visual rotation set value {qy:1,qw:0}
execute if score #vis_orient xq_ctx matches 1 if score @s xq_piece matches 1.. run data modify storage xiangqi:visual rotation set value {qy:-0.7071068,qw:0.7071068}
execute if score #vis_orient xq_ctx matches 1 if score @s xq_piece matches ..-1 run data modify storage xiangqi:visual rotation set value {qy:0.7071068,qw:0.7071068}
data modify storage xiangqi:visual qy set from storage xiangqi:visual rotation.qy
data modify storage xiangqi:visual qw set from storage xiangqi:visual rotation.qw
