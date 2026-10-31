tag @s add ch.moving
scoreboard players operation @s ch_sq = #vis_to ch_ctx
execute if score #vis_promotion ch_ctx matches ..-1 run scoreboard players operation #vis_promotion ch_ctx *= #vis_owner ch_ctx
execute if score #vis_promotion ch_ctx matches 2..5 run scoreboard players operation @s ch_piece = #vis_promotion ch_ctx
execute if score #vis_promotion ch_ctx matches 2..5 run scoreboard players operation @s ch_piece *= #vis_owner ch_ctx
function chess:visual/man_model
function chess:visual/man_pose
scoreboard players operation #vis_piece ch_ctx = @s ch_piece
execute as @e[type=minecraft:interaction,tag=ch.piece_hit] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_from ch_ctx run function chess:visual/move_hit with storage chess:visual
