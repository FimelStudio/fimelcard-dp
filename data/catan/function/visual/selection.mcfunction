execute store result score #vis_type ca_ctx run data get storage catan:visual selection.type
execute unless score #vis_type ca_ctx matches 1..3 run return 0
$scoreboard players set #vis_target ca_ctx $(target)
execute if score #vis_type ca_ctx matches 1 unless score #vis_target ca_ctx matches 0..18 run return 0
execute if score #vis_type ca_ctx matches 2 unless score #vis_target ca_ctx matches 0..53 run return 0
execute if score #vis_type ca_ctx matches 3 unless score #vis_target ca_ctx matches 0..71 run return 0
$data modify storage catan:visual target set value $(target)
$data modify storage catan:visual id set value $(target)
execute if data storage catan:visual selection{type:1} run data modify storage catan:visual collection set value "hexes"
execute if data storage catan:visual selection{type:1} run data modify storage catan:visual model set value "highlight/hex"
execute if data storage catan:visual selection{type:2} run data modify storage catan:visual collection set value "vertices"
execute if data storage catan:visual selection{type:2} run data modify storage catan:visual model set value "highlight/vertex"
execute if data storage catan:visual selection{type:3} run data modify storage catan:visual collection set value "edges"
execute if data storage catan:visual selection{type:3} run data modify storage catan:visual model set value "highlight/edge"
function catan:visual/coordinate with storage catan:visual
execute if data storage catan:visual selection{type:2} run data modify storage catan:visual pose.scale set from storage catan:visual geom.highlight_vertex_scale
function catan:visual/piece_y
data modify storage catan:visual kind set value 9
function catan:visual/spawn
execute as @e[tag=ca.visual,scores={ca_vkind=9}] if score @s ct_id = #vis_table ca_ctx run data merge entity @s {Glowing:1b,glow_color_override:16773283}
