scoreboard players set @s ma_anim 0
function magical_athlete:visual/refresh
execute if score @s ma_state matches 5 run return run function magical_athlete:game/win
function magical_athlete:ui/refresh
