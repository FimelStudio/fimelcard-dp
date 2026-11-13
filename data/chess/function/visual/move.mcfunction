# 规则 marker 已提交；显示实体仍停在旧位置。所有临时状态在本函数链中消费。
function chess:visual/context
scoreboard players set #vis_duration ch_ctx 8
scoreboard players set #vis_capture ch_ctx -1
scoreboard players set #vis_rook_from ch_ctx -1
scoreboard players set #vis_rook_to ch_ctx -1
scoreboard players set #vis_promotion ch_ctx 0
execute store result score #vis_from ch_ctx run data get entity @s data.chess.last.from
execute store result score #vis_to ch_ctx run data get entity @s data.chess.last.to
execute store result score #vis_piece ch_ctx run data get entity @s data.chess.last.piece
execute store result score #vis_taken ch_ctx run data get entity @s data.chess.last.captured
execute store result score #vis_capture ch_ctx run data get entity @s data.chess.last.capture_sq
execute store result score #vis_rook_from ch_ctx run data get entity @s data.chess.last.rook_from
execute store result score #vis_rook_to ch_ctx run data get entity @s data.chess.last.rook_to
execute store result score #vis_promotion ch_ctx run data get entity @s data.chess.last.promotion
scoreboard players set #vis_owner ch_ctx 1
execute if score #vis_piece ch_ctx matches ..-1 run scoreboard players set #vis_owner ch_ctx -1
execute unless score #vis_taken ch_ctx matches 0 if score #vis_capture ch_ctx matches 0..63 run function chess:visual/capture
execute as @e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_from ch_ctx run function chess:visual/move_man
execute if score #vis_rook_from ch_ctx matches 0..63 as @e[type=minecraft:item_display,tag=ch.man,tag=!ch.captured] if score @s ct_id = #vis_table ch_ctx if score @s ch_sq = #vis_rook_from ch_ctx run function chess:visual/move_rook
function chess:visual/select
