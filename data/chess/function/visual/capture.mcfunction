scoreboard players set #vis_slot ch_ctx 0
execute if score #vis_owner ch_ctx matches 1 run scoreboard players operation #vis_slot ch_ctx = @s ch_wcapt
execute if score #vis_owner ch_ctx matches -1 run scoreboard players operation #vis_slot ch_ctx = @s ch_bcapt
data modify storage chess:visual captured set value {piece:0,owner:0,slot:0}
execute store result storage chess:visual captured.piece int 1 run scoreboard players get #vis_taken ch_ctx
execute store result storage chess:visual captured.owner int 1 run scoreboard players get #vis_owner ch_ctx
execute store result storage chess:visual captured.slot int 1 run scoreboard players get #vis_slot ch_ctx
data modify entity @s data.chess.captured append from storage chess:visual captured
execute if score #vis_owner ch_ctx matches 1 run scoreboard players add @s ch_wcapt 1
execute if score #vis_owner ch_ctx matches -1 run scoreboard players add @s ch_bcapt 1
execute as @e[type=minecraft:interaction,tag=ch.piece_hit] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_capture ch_ctx run kill @s
execute as @e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_capture ch_ctx run function chess:visual/capture_man
