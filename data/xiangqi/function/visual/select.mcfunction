function xiangqi:visual/context
execute as @e[tag=xq.highlight] if score @s ct_id = #vis_table xq_ctx run kill @s
scoreboard players operation #vis_sq xq_ctx = @s xq_sel
execute if score #vis_sq xq_ctx matches 0..89 positioned ~ ~1.035 ~ summon minecraft:item_display run function xiangqi:visual/highlight
function xiangqi:hints/refresh
