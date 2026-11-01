scoreboard players operation #vis_table ll_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=ll.fx] if score @s ct_id = #vis_table ll_ctx run function love_letter:visual/fx_tick
