function catan:sound/stop
execute unless score @s ct_game matches 21 run return 0
execute unless score @s ct_state matches 1 run return 0
execute if score @s ca_finish matches 1.. run return 0
execute if score @s ca_state matches 11 run return 0
execute unless score @s ca_music matches 1 run return 0
scoreboard players set @s ca_bgm 1000
execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx run function catan:sound/start_player
