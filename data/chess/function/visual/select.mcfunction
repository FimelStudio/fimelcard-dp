function chess:visual/context
execute as @e[tag=ch.highlight] if score @s ct_id = #vis_table ch_ctx run kill @s
scoreboard players operation #vis_sq ch_ctx = @s ch_sel
execute if score #vis_sq ch_ctx matches 0..63 positioned ~ ~1.035 ~ summon minecraft:item_display run function chess:visual/highlight
function chess:hints/refresh
