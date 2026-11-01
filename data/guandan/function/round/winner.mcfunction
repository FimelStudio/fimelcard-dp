scoreboard players operation #winseat gd_ctx = @s gd_seat
execute as @a[tag=gd.audience] if score @s gd_seat = #winseat gd_ctx at @s run function guandan:round/firework
