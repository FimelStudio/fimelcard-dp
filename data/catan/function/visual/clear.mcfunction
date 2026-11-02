scoreboard players operation #vis_table ca_ctx = @s ct_id
execute as @e[tag=ca.visual] if score @s ct_id = #vis_table ca_ctx run kill @s
scoreboard players set @s ca_vtimer 0
scoreboard players set @s ca_vkind 0
data remove entity @s data.catan.visual_events
data remove entity @s data.catan.visual_active
data remove entity @s data.catan.visual_motion
