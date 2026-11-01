scoreboard players operation #setting_table gd_ctx = @s ct_id
execute as @a if score @s gd_settable = #setting_table gd_ctx run function guandan:settings/clear_session
