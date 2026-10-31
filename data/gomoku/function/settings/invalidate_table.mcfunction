scoreboard players operation #ui_setting_table gm_ctx = @s ct_id
execute as @a if score @s gm_set_table = #ui_setting_table gm_ctx run function gomoku:settings/clear_session
