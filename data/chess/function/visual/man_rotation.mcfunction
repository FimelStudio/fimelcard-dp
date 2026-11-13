# 王额外水平旋转 90°，马额外水平旋转 180°；统一处理摆放、移动、吃子及重建。
execute if score #vis_orient ch_ctx matches 0 if score @s ch_piece matches 1.. run data modify storage chess:visual rotation set value {qy:-0.7071068,qw:0.7071068}
execute if score #vis_orient ch_ctx matches 0 if score @s ch_piece matches 6 run data modify storage chess:visual rotation set value {qy:0.0,qw:1}
execute if score #vis_orient ch_ctx matches 0 if score @s ch_piece matches 2 run data modify storage chess:visual rotation set value {qy:0.7071068,qw:0.7071068}
execute if score #vis_orient ch_ctx matches 0 if score @s ch_piece matches ..-1 run data modify storage chess:visual rotation set value {qy:0.7071068,qw:0.7071068}
execute if score #vis_orient ch_ctx matches 0 if score @s ch_piece matches -6 run data modify storage chess:visual rotation set value {qy:1,qw:0}
execute if score #vis_orient ch_ctx matches 0 if score @s ch_piece matches -2 run data modify storage chess:visual rotation set value {qy:0.7071068,qw:-0.7071068}
execute if score #vis_orient ch_ctx matches 1 if score @s ch_piece matches 1.. run data modify storage chess:visual rotation set value {qy:-1,qw:0}
execute if score #vis_orient ch_ctx matches 1 if score @s ch_piece matches 6 run data modify storage chess:visual rotation set value {qy:-0.7071068,qw:0.7071068}
execute if score #vis_orient ch_ctx matches 1 if score @s ch_piece matches 2 run data modify storage chess:visual rotation set value {qy:0.0,qw:1}
execute if score #vis_orient ch_ctx matches 1 if score @s ch_piece matches ..-1 run data modify storage chess:visual rotation set value {qy:0.0,qw:1}
execute if score #vis_orient ch_ctx matches 1 if score @s ch_piece matches -6 run data modify storage chess:visual rotation set value {qy:0.7071068,qw:0.7071068}
execute if score #vis_orient ch_ctx matches 1 if score @s ch_piece matches -2 run data modify storage chess:visual rotation set value {qy:1,qw:0}
data modify storage chess:visual qy set from storage chess:visual rotation.qy
data modify storage chess:visual qw set from storage chess:visual rotation.qw
