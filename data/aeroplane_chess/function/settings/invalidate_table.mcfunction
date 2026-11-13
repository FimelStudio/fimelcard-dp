scoreboard players operation #setting_table ac_ctx = @s ct_id
execute as @a if score @s ac_set_table = #setting_table ac_ctx run function aeroplane_chess:settings/clear_session
