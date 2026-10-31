scoreboard players operation #vis_table un_ctx = @s ct_id
execute as @e[tag=un.visual] if score @s ct_id = #vis_table un_ctx run kill @s
