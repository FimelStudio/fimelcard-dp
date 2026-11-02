execute store result score #vis_scale ca_ctx run data get storage catan:visual pose.scale 100000
scoreboard players set #vis_two ca_ctx 2
scoreboard players operation #vis_scale ca_ctx /= #vis_two ca_ctx
scoreboard players add #vis_scale ca_ctx 2400
execute store result storage catan:visual pose.y double 0.00001 run scoreboard players get #vis_scale ca_ctx
