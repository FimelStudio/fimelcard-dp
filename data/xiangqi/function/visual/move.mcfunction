# 规则 marker 已提交；显示实体仍停在旧位置。所有临时状态在本函数链中消费。
function xiangqi:visual/context
scoreboard players set #vis_duration xq_ctx 8
scoreboard players set #vis_capture xq_ctx -1
execute store result score #vis_from xq_ctx run data get entity @s data.xiangqi.last.from
execute store result score #vis_to xq_ctx run data get entity @s data.xiangqi.last.to
execute store result score #vis_piece xq_ctx run data get entity @s data.xiangqi.last.piece
execute store result score #vis_taken xq_ctx run data get entity @s data.xiangqi.last.captured
execute store result score #vis_capture xq_ctx run data get entity @s data.xiangqi.last.capture_sq
scoreboard players set #vis_owner xq_ctx 1
execute if score #vis_piece xq_ctx matches ..-1 run scoreboard players set #vis_owner xq_ctx -1
execute unless score #vis_taken xq_ctx matches 0 if score #vis_capture xq_ctx matches 0..89 run function xiangqi:visual/capture
execute as @e[type=minecraft:item_display,tag=xq.man,tag=!xq.captured] if score @s ct_id = #vis_table xq_ctx if score @s xq_sq = #vis_from xq_ctx run function xiangqi:visual/move_man
function xiangqi:visual/select
