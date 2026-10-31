tag @s add ch.visual
tag @s add ch.cell
tag @s add ch.piece_hit
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
data merge entity @s {response:1b}
function chess:visual/hit_shape
