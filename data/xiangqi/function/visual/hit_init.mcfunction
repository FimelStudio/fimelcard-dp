tag @s add xq.visual
tag @s add xq.cell
tag @s add xq.piece_hit
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players operation @s xq_covered = #vis_covered xq_ctx
data merge entity @s {response:1b}
function xiangqi:visual/hit_shape
