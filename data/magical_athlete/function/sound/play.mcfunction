execute if score @s ct_paused matches 1 run return 0
execute unless score @s ma_music matches 1 run return 0
function magical_athlete:sound/context
execute if data entity @s data.magical_athlete{track:1} run return run function magical_athlete:sound/play_wild
function magical_athlete:sound/play_mild
