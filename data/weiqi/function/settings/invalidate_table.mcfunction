scoreboard players operation #ui_setting_table go_ctx = @s ct_id
execute as @a if score @s go_set_table = #ui_setting_table go_ctx run function weiqi:settings/clear_session
