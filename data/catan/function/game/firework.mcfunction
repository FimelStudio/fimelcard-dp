scoreboard players operation #winner ca_ctx = @s ca_winner
execute as @a[tag=ca.audience] if score @s ca_side = #winner ca_ctx at @s run function catan:game/firework_player
