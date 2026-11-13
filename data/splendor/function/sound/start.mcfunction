function splendor:sound/stop
execute unless score @s ct_game matches 22 run return 0
execute unless score @s ct_state matches 1 run return 0
execute if score @s ct_paused matches 1 run return 0
execute unless score @s sp_music matches 1 run return 0
execute if data entity @s data.splendor{phase:4} run return 0
scoreboard players set @s sp_bgm 1000
execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #sound_table sp_ctx if score @s ct_id = #sound_table sp_ctx at @s run function splendor:sound/start_player
