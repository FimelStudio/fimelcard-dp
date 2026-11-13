function magical_athlete:system/context
function magical_athlete:sound/stop
execute if score @s ct_state matches 1 if score @s ma_music matches 1 run function magical_athlete:sound/start
