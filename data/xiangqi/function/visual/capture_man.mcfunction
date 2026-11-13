tag @s add xq.captured
tag @s add xq.moving
scoreboard players set @s xq_sq -1
scoreboard players operation @s xq_owner = #vis_owner xq_ctx
scoreboard players operation @s xq_slot = #vis_slot xq_ctx
scoreboard players operation @s xq_covered = #vis_taken_covered xq_ctx
function xiangqi:visual/man_model
function xiangqi:visual/captured_pose
