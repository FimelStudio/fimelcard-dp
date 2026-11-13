scoreboard players operation #hint_table xq_ctx = @s ct_id
execute as @e[tag=xq.hint] if score @s ct_id = #hint_table xq_ctx run kill @s
