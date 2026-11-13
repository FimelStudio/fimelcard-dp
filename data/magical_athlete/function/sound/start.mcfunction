execute if score @s ct_paused matches 1 run return 0
function magical_athlete:sound/stop
execute if score @s ma_music matches 1 run function magical_athlete:sound/play
