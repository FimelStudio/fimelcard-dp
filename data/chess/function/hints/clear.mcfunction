scoreboard players operation #hint_table ch_ctx = @s ct_id
execute as @e[tag=ch.hint] if score @s ct_id = #hint_table ch_ctx run kill @s
