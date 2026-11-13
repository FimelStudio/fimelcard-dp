scoreboard players operation #vc_table dd_ctx = @s dd_id
execute as @e[type=minecraft:item_display,tag=dd.public_card] if score @s dd_id = #vc_table dd_ctx run kill @s
