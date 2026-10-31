scoreboard players operation #vis_table gm_ctx = @s ct_id
execute as @e[tag=gm.visual] if score @s ct_id = #vis_table gm_ctx run kill @s
