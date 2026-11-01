scoreboard players operation #vis_table gd_ctx = @s ct_id
execute as @e[tag=gd.visual] if score @s ct_id = #vis_table gd_ctx run kill @s
