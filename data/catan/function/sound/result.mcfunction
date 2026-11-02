function catan:sound/stop
scoreboard players operation #sound_winner ca_ctx = @s ca_winner
execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx if score @s ca_side = #sound_winner ca_ctx run function catan:sound/win_player
execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx unless score @s ca_side = #sound_winner ca_ctx run function catan:sound/lose_player
