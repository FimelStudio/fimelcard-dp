tag @s add xq.moving
scoreboard players operation @s xq_sq = #vis_to xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players set @s xq_covered 0
function xiangqi:visual/man_model
function xiangqi:visual/man_pose
scoreboard players operation #vis_piece xq_ctx = @s xq_piece
execute as @e[type=minecraft:interaction,tag=xq.piece_hit] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_from xq_ctx run function xiangqi:visual/move_hit with storage xiangqi:visual
