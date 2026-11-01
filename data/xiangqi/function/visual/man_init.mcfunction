tag @s add xq.visual
tag @s add xq.man
scoreboard players operation @s ct_id = #vis_table xq_ctx
scoreboard players operation @s xq_sq = #vis_sq xq_ctx
scoreboard players operation @s xq_piece = #vis_piece xq_ctx
scoreboard players operation @s xq_covered = #vis_covered xq_ctx
scoreboard players set @s xq_owner 0
scoreboard players set @s xq_slot -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function xiangqi:visual/man_model
function xiangqi:visual/man_pose
