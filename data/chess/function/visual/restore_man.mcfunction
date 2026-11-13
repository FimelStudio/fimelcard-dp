tag @s add ch.visual
tag @s add ch.man
tag @s add ch.captured
scoreboard players operation @s ct_id = #vis_table ch_ctx
scoreboard players operation @s ch_piece = #vis_piece ch_ctx
scoreboard players operation @s ch_owner = #vis_owner ch_ctx
scoreboard players operation @s ch_slot = #vis_slot ch_ctx
scoreboard players set @s ch_sq -1
data merge entity @s {item_display:"none",brightness:{block:15,sky:15},shadow_radius:0f,view_range:24f}
function chess:visual/man_model
function chess:visual/captured_pose
