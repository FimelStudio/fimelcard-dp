execute store result score #vis_total ca_ctx run data get storage catan:visual total
execute store result score #vis_remaining ca_ctx run data get storage catan:visual remaining
scoreboard players operation #vis_t ca_ctx = #vis_total ca_ctx
scoreboard players operation #vis_t ca_ctx -= #vis_remaining ca_ctx
scoreboard players set #vis_1000 ca_ctx 1000
scoreboard players operation #vis_t ca_ctx *= #vis_1000 ca_ctx
scoreboard players operation #vis_t ca_ctx /= #vis_total ca_ctx
execute store result score #vis_from ca_ctx run data get storage catan:visual motion.from[0] 100000
execute store result score #vis_to ca_ctx run data get storage catan:visual motion.to.x 100000
scoreboard players operation #vis_to ca_ctx -= #vis_from ca_ctx
scoreboard players operation #vis_to ca_ctx *= #vis_t ca_ctx
scoreboard players operation #vis_to ca_ctx /= #vis_1000 ca_ctx
scoreboard players operation #vis_to ca_ctx += #vis_from ca_ctx
execute store result storage catan:visual pose.x double 0.00001 run scoreboard players get #vis_to ca_ctx
execute store result score #vis_from ca_ctx run data get storage catan:visual motion.from[1] 100000
execute store result score #vis_to ca_ctx run data get storage catan:visual motion.to.y 100000
scoreboard players operation #vis_to ca_ctx -= #vis_from ca_ctx
scoreboard players operation #vis_to ca_ctx *= #vis_t ca_ctx
scoreboard players operation #vis_to ca_ctx /= #vis_1000 ca_ctx
scoreboard players operation #vis_to ca_ctx += #vis_from ca_ctx
execute store result storage catan:visual pose.y double 0.00001 run scoreboard players get #vis_to ca_ctx
execute store result score #vis_from ca_ctx run data get storage catan:visual motion.from[2] 100000
execute store result score #vis_to ca_ctx run data get storage catan:visual motion.to.z 100000
scoreboard players operation #vis_to ca_ctx -= #vis_from ca_ctx
scoreboard players operation #vis_to ca_ctx *= #vis_t ca_ctx
scoreboard players operation #vis_to ca_ctx /= #vis_1000 ca_ctx
scoreboard players operation #vis_to ca_ctx += #vis_from ca_ctx
execute store result storage catan:visual pose.z double 0.00001 run scoreboard players get #vis_to ca_ctx
scoreboard players set #vis_arc ca_ctx 1000
scoreboard players operation #vis_arc ca_ctx -= #vis_t ca_ctx
scoreboard players operation #vis_arc ca_ctx *= #vis_t ca_ctx
execute store result score #vis_y ca_ctx run data get storage catan:visual pose.y 1000000
scoreboard players operation #vis_y ca_ctx += #vis_arc ca_ctx
execute store result storage catan:visual pose.y double 0.000001 run scoreboard players get #vis_y ca_ctx
