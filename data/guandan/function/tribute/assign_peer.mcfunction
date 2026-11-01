scoreboard players operation @s gd_peer = #second gd_ctx
execute if score @s gd_seat = #lead gd_ctx run scoreboard players operation @s gd_peer = #head gd_ctx
scoreboard players operation #donor gd_ctx = @s gd_seat
scoreboard players operation #receiver gd_ctx = @s gd_peer
execute as @e[tag=gd.board] if score @s gd_seat = #receiver gd_ctx run scoreboard players operation @s gd_peer = #donor gd_ctx
execute as @e[tag=gd.board] if score @s gd_seat = #receiver gd_ctx run scoreboard players set @s gd_return 1
