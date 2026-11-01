scoreboard players operation #vc_table dd_ctx = @e[tag=dd.current,limit=1] dd_id
scoreboard players operation #vc_seat dd_ctx = @s dd_seat
execute as @e[type=minecraft:item_display,tag=dd.public_card] if score @s dd_id = #vc_table dd_ctx if score @s dd_owner = #vc_seat dd_ctx run kill @s
