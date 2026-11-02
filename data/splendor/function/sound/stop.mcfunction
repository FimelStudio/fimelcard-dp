function splendor:sound/context
scoreboard players set @s sp_bgm 0
execute as @a[scores={sp_bgm_on=1}] if score @s sp_bgm_table = #sound_table sp_ctx run function splendor:sound/stop_player
