scoreboard players set @s ma_pulse 0
function magical_athlete:system/context
execute as @a[tag=ma.audience] run function magical_athlete:hud/build
