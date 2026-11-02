execute unless score @s ct_game matches 21 run return run function catan:sound/stop
execute unless score @s ct_state matches 1 run return run function catan:sound/stop
execute if score @s ca_finish matches 1.. run return run function catan:sound/stop
execute if score @s ca_state matches 11 run return run function catan:sound/stop
execute unless score @s ca_music matches 1 run return run function catan:sound/stop
scoreboard players operation #sound_table ca_ctx = @s ct_id
execute as @a[scores={ca_bgm_on=1}] if score @s ca_bgm_table = #sound_table ca_ctx run function catan:sound/verify_player
execute if score @s ca_bgm matches 1.. run scoreboard players remove @s ca_bgm 1
execute unless score @s ca_bgm matches 1.. run return run function catan:sound/start
execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx unless score @s ca_bgm_on matches 1 run function catan:sound/start_player
