function chess:visual/clear_board
function chess:visual/context
scoreboard players set #vis_duration ch_ctx 0
execute positioned ~ ~1.02 ~ summon minecraft:item_display run function chess:visual/board with storage chess:visual
execute if score #vis_cap ch_ctx matches 4 if score #vis_orient ch_ctx matches 0 run function chess:visual/cells4_0
execute if score #vis_cap ch_ctx matches 4 if score #vis_orient ch_ctx matches 1 run function chess:visual/cells4_1
execute if score #vis_cap ch_ctx matches 8 if score #vis_orient ch_ctx matches 0 run function chess:visual/cells8_0
execute if score #vis_cap ch_ctx matches 8 if score #vis_orient ch_ctx matches 1 run function chess:visual/cells8_1
execute as @e[type=minecraft:marker,tag=ch.square] if score @s ct_id = #vis_table ch_ctx unless score @s ch_piece matches 0 run function chess:visual/spawn_man
data modify storage chess:visual restore set from entity @s data.chess.captured
execute if data storage chess:visual restore[0] run function chess:visual/restore_captured
function chess:visual/select
