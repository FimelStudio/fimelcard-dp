scoreboard players operation #set_table ma_ctx = @s ct_id
execute as @a if score @s ma_settable = #set_table ma_ctx run function magical_athlete:settings/clear_session
