data modify storage catan:visual motion set from entity @s data.catan.visual_motion
execute store result storage catan:visual remaining int 1 run scoreboard players get @s ca_vtimer
data modify storage catan:visual total set value 8
function catan:visual/interpolate
data modify storage catan:visual pose.scale set from storage catan:visual geom.robber_scale
data modify storage catan:visual pose.qx set value 0
data modify storage catan:visual pose.qy set value 0
data modify storage catan:visual pose.qz set value 0
data modify storage catan:visual pose.qw set value 1
execute as @e[tag=ca.visual,scores={ca_vkind=7}] if score @s ct_id = #vis_table ca_ctx run function catan:visual/pose with storage catan:visual pose
execute if score @s ca_vtimer matches 4 run function catan:visual/particle_robber with storage catan:visual pose
