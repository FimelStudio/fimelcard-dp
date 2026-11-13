function magical_athlete:visual/clear
function magical_athlete:visual/context
data modify storage magical_athlete:visual track set value "mild"
execute if score @s ma_track matches 2 run data modify storage magical_athlete:visual track set value "wild"
function magical_athlete:visual/board_spawn with storage magical_athlete:visual
function magical_athlete:visual/dice_spawn
