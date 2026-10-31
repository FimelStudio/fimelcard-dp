tag @s add ch.captured
tag @s add ch.moving
scoreboard players set @s ch_sq -1
scoreboard players operation @s ch_owner = #vis_owner ch_ctx
scoreboard players operation @s ch_slot = #vis_slot ch_ctx
function chess:visual/captured_pose
