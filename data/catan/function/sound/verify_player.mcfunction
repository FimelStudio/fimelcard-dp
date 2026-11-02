execute unless entity @s[tag=ca.player,tag=ct.player] run return run function catan:sound/stop_player
execute unless score @s ca_table = #sound_table ca_ctx run return run function catan:sound/stop_player
execute unless score @s ct_id = #sound_table ca_ctx run return run function catan:sound/stop_player
