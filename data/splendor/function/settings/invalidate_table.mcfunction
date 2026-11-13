scoreboard players operation #set_table sp_ctx = @s ct_id
execute as @a if score @s sp_settable = #set_table sp_ctx run function splendor:settings/clear_session
