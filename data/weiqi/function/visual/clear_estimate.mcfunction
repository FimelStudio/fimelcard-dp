scoreboard players operation #vis_table go_ctx = @s ct_id
execute as @e[tag=go.territory] if score @s ct_id = #vis_table go_ctx run kill @s
execute as @e[tag=go.dead_mark] if score @s ct_id = #vis_table go_ctx run kill @s
