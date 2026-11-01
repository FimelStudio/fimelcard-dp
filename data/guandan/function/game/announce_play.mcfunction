scoreboard players operation #announce gd_ctx = @s gd_actor
execute as @e[tag=gd.board] if score @s gd_seat = #announce gd_ctx run function guandan:game/announce_part
