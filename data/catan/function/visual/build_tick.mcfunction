data modify storage catan:visual target set from storage catan:visual event.target
data modify storage catan:visual collection set value "vertices"
execute if score @s ca_vkind matches 1 run data modify storage catan:visual collection set value "edges"
function catan:visual/coordinate with storage catan:visual
data modify storage catan:visual kind set value 6
execute if score @s ca_vkind matches 1 run data modify storage catan:visual kind set value 5
scoreboard players set #vis_factor ca_ctx 8
scoreboard players operation #vis_factor ca_ctx -= @s ca_vtimer
scoreboard players add #vis_factor ca_ctx 1
scoreboard players set #vis_total ca_ctx 9
execute store result score #vis_scale ca_ctx run data get storage catan:visual pose.scale 100000
scoreboard players operation #vis_scale ca_ctx *= #vis_factor ca_ctx
scoreboard players operation #vis_scale ca_ctx /= #vis_total ca_ctx
execute store result storage catan:visual pose.scale double 0.00001 run scoreboard players get #vis_scale ca_ctx
function catan:visual/piece_y
function catan:visual/build_entity with storage catan:visual
execute if score @s ca_vtimer matches 8 run function catan:visual/particle_build with storage catan:visual pose
