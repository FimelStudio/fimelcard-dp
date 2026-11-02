data modify storage catan:visual kind set value 10
data modify storage catan:visual id set value 0
data modify storage catan:visual pose.x set from storage catan:visual motion.from[0]
data modify storage catan:visual pose.y set from storage catan:visual motion.from[1]
data modify storage catan:visual pose.z set from storage catan:visual motion.from[2]
data modify storage catan:visual pose.scale set from storage catan:visual geom.icon_scale
data modify storage catan:visual pose.qx set value -0.7071067811865476
data modify storage catan:visual pose.qy set value 0
data modify storage catan:visual pose.qz set value 0
data modify storage catan:visual pose.qw set value 0.7071067811865476
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function catan:visual/fx_init with storage catan:visual
