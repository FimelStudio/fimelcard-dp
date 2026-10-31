function xiangqi:visual/clear_board
function xiangqi:visual/context
scoreboard players set #vis_duration xq_ctx 0
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function xiangqi:visual/board with storage xiangqi:visual
execute if score #vis_cap xq_ctx matches 4 if score #vis_orient xq_ctx matches 0 run function xiangqi:visual/cells4_0
execute if score #vis_cap xq_ctx matches 4 if score #vis_orient xq_ctx matches 1 run function xiangqi:visual/cells4_1
execute if score #vis_cap xq_ctx matches 8 if score #vis_orient xq_ctx matches 0 run function xiangqi:visual/cells8_0
execute if score #vis_cap xq_ctx matches 8 if score #vis_orient xq_ctx matches 1 run function xiangqi:visual/cells8_1
execute as @e[type=minecraft:marker,tag=xq.square] if score @s ct_id = #vis_table xq_ctx unless score @s xq_piece matches 0 run function xiangqi:visual/spawn_man
data modify storage xiangqi:visual restore set from entity @s data.xiangqi.captured
execute if data storage xiangqi:visual restore[0] run function xiangqi:visual/restore_captured
function xiangqi:visual/select
