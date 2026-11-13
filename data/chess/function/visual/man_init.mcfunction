tag @s add ch.visual
tag @s add ch.man
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_sq = #vis_sq ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
scoreboard players set @s ch_owner 0
scoreboard players set @s ch_slot -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function chess:visual/man_model
function chess:visual/man_pose
