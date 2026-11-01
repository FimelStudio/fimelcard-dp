scoreboard players operation #gift gd_ctx = @s gd_returnid
scoreboard players operation #from gd_ctx = @s gd_seat
scoreboard players operation #to gd_ctx = @s gd_peer
execute as @e[tag=gd.cards] if score @s gd_id = #gift gd_ctx run function guandan:tribute/transfer
