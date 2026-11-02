scoreboard players remove @s ca_vlife 1
data modify storage catan:visual motion set from entity @s item.components."minecraft:custom_data".catan_fx
execute store result storage catan:visual remaining int 1 run scoreboard players get @s ca_vlife
data modify storage catan:visual total set value 8
function catan:visual/interpolate
data modify storage catan:visual pose.scale set from storage catan:visual geom.icon_scale
data modify storage catan:visual pose.qx set value -0.7071067811865476
data modify storage catan:visual pose.qy set value 0
data modify storage catan:visual pose.qz set value 0
data modify storage catan:visual pose.qw set value 0.7071067811865476
function catan:visual/pose with storage catan:visual pose
execute if score @s ca_vlife matches 4 run function catan:visual/particle_resource with storage catan:visual pose
execute if score @s ca_vlife matches ..0 run kill @s
