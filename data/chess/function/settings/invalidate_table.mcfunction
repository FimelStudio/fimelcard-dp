scoreboard players operation #ui_setting_table ch_ctx = @s ct_id
execute as @a if score @s ch_set_table = #ui_setting_table ch_ctx run function chess:settings/clear_session
