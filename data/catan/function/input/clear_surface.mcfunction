scoreboard players operation #input_table ca_ctx = @s ct_id
execute as @e[type=minecraft:interaction,tag=ca.surface] if score @s ct_id = #input_table ca_ctx run kill @s
