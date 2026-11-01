scoreboard players set @s gd_tick 0
function guandan:system/context
scoreboard players set #online gd_ctx 0
execute as @a[tag=gd.audience] run scoreboard players add #online gd_ctx 1
execute unless score #online gd_ctx matches 4 run return run function guandan:game/player_left
function guandan:hud/refresh
