execute as @e[type=minecraft:item_display,tag=sp.visual] if score @s sp_table = #vis_table sp_ctx if score @s sp_vkind = #vis_kind sp_ctx if score @s sp_vid = #vis_id sp_ctx run tag @s add sp.selected
execute as @e[type=minecraft:item_display,tag=sp.selected] if score @s sp_table = #vis_table sp_ctx run data merge entity @s {Glowing:1b,glow_color_override:16766720}
