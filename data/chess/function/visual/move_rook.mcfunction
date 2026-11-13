tag @s add ch.moving
scoreboard players operation @s ch_sq = #vis_rook_to ch_ctx
function chess:visual/man_pose
scoreboard players operation #vis_piece ch_ctx = @s ch_piece
execute as @e[type=minecraft:interaction,tag=ch.piece_hit] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_rook_from ch_ctx run function chess:visual/move_hit with storage chess:visual
