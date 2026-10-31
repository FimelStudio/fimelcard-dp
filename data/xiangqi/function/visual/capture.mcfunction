scoreboard players set #vis_slot xq_ctx 0
execute if score #vis_owner xq_ctx matches 1 run scoreboard players operation #vis_slot xq_ctx = @s xq_rcapt
execute if score #vis_owner xq_ctx matches -1 run scoreboard players operation #vis_slot xq_ctx = @s xq_bcapt
data modify storage xiangqi:visual captured set value {piece:0,owner:0,slot:0}
execute store result storage xiangqi:visual captured.piece int 1 run scoreboard players get #vis_taken xq_ctx
execute store result storage xiangqi:visual captured.owner int 1 run scoreboard players get #vis_owner xq_ctx
execute store result storage xiangqi:visual captured.slot int 1 run scoreboard players get #vis_slot xq_ctx
data modify entity @s data.xiangqi.captured append from storage xiangqi:visual captured
execute if score #vis_owner xq_ctx matches 1 run scoreboard players add @s xq_rcapt 1
execute if score #vis_owner xq_ctx matches -1 run scoreboard players add @s xq_bcapt 1
execute as @e[type=minecraft:interaction,tag=xq.piece_hit] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_capture xq_ctx run kill @s
execute as @e[type=minecraft:item_display,tag=xq.man,tag=!xq.captured] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_capture xq_ctx run function xiangqi:visual/capture_man
