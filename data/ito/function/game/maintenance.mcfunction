scoreboard players set @s it_pulse 0
function ito:system/context
scoreboard players set #online it_ctx 0
execute as @a[tag=it.audience] run scoreboard players add #online it_ctx 1
execute unless score #online it_ctx = @s it_count run return run function ito:game/player_left
function ito:hud/refresh
