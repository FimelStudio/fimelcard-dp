$execute as @e[type=minecraft:item_display,tag=go.man,scores={go_sq=$(sq)}] if score @s ct_id = #vis_table go_ctx run function weiqi:visual/retract
