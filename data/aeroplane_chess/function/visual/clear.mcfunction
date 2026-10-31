scoreboard players operation #vis_table ac_ctx = @s ct_id
execute as @e[tag=ac.visual] if score @s ct_id = #vis_table ac_ctx run kill @s
