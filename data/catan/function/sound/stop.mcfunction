scoreboard players operation #sound_table ca_ctx = @s ct_id
scoreboard players set @s ca_bgm 0
execute as @a[scores={ca_bgm_on=1}] if score @s ca_bgm_table = #sound_table ca_ctx run function catan:sound/stop_player
