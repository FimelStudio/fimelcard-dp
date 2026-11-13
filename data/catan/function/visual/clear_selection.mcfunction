scoreboard players operation #vis_table ca_ctx = @s ct_id
execute as @e[tag=ca.visual,scores={ca_vkind=9}] if score @s ct_id = #vis_table ca_ctx run kill @s
