tag @s add ac.plane
scoreboard players operation @s ct_id = #table ac_ctx
$scoreboard players set @s ac_color $(color)
$scoreboard players set @s ac_plane $(plane)
scoreboard players set @s ac_pos -1
scoreboard players set @s ac_prev -1
scoreboard players set @s ac_legal 0
scoreboard players set @s ac_active 1
