$data modify storage magical_athlete:direct pose set from storage magical_athlete:visual layout.pawns[0][$(pos)]
data modify storage magical_athlete:direct x set from storage magical_athlete:direct pose.x
data modify storage magical_athlete:direct z set from storage magical_athlete:direct pose.z
data modify storage magical_athlete:direct width set value 0.28
$data modify storage magical_athlete:direct id set value $(pos)
data modify storage magical_athlete:direct type set value 3
function magical_athlete:direct/hit_spawn with storage magical_athlete:direct
