tag @s add gd.part
scoreboard players operation @s ct_id = #table gd_ctx
scoreboard players operation @s gd_seat = #join_seat gd_ctx
scoreboard players operation @s gd_order = #join_order gd_ctx
scoreboard players operation @s gd_team = #join_team gd_ctx
scoreboard players set @s gd_points 0
scoreboard players set @s gd_prevrank 0
scoreboard players set @s gd_rank 0
scoreboard players set @s gd_count 0
data modify entity @s data.gd_name set from storage guandan:name resolved
data modify entity @s data.last_play set value []
data modify entity @s data.last_label set value ""
