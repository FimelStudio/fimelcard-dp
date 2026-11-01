execute as @e[tag=gd.box] if score @s ct_id = #vis_table gd_ctx run kill @s
execute positioned ~-0.22 ~1.04 ~0.55 summon minecraft:item_display run function guandan:visual/box
execute positioned ~0.22 ~1.04 ~0.55 summon minecraft:item_display run function guandan:visual/box
