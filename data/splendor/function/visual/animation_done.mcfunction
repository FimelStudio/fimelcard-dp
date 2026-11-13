execute as @e[tag=sp.anim] if score @s sp_table = #vis_table sp_ctx run kill @s
data remove entity @s data.splendor.visual_active
execute at @s run particle minecraft:enchant ~ ~1.15 ~ .40 .05 .40 0.02 10 force
