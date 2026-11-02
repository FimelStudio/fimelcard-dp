data modify storage catan:visual target set from storage catan:visual event.target
data modify storage catan:visual collection set value "hexes"
function catan:visual/coordinate with storage catan:visual
data modify storage catan:visual pose.scale set from storage catan:visual geom.robber_scale
function catan:visual/piece_y
data modify entity @s data.catan.visual_motion set value {}
data modify entity @s data.catan.visual_motion.to set from storage catan:visual pose
data modify storage catan:visual from set value [0.0,0.1,0.0]
execute as @e[tag=ca.visual,scores={ca_vkind=7},limit=100] if score @s ct_id = #vis_table ca_ctx run data modify storage catan:visual from set from entity @s transformation.translation
data modify entity @s data.catan.visual_motion.from set from storage catan:visual from
function catan:visual/robber_tick
