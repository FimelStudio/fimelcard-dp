scoreboard players operation #setting_table ll_ctx = @s ct_id
execute as @a if score @s ll_settable = #setting_table ll_ctx run function love_letter:settings/clear_session
