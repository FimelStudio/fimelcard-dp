scoreboard players operation #vis_table ch_ctx = @s ct_id
execute as @e[tag=ch.visual] if score @s ct_id = #vis_table ch_ctx run kill @s
