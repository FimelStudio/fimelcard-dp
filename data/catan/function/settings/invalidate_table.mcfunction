scoreboard players operation #set_table ca_ctx = @s ct_id
execute as @a if score @s ca_settable = #set_table ca_ctx run function catan:settings/clear_session
