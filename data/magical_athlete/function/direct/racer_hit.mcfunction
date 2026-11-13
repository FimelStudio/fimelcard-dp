$data modify storage magical_athlete:visual racer set from entity @s data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:visual racer{status:2} run return 0
$data modify storage magical_athlete:visual racer.index set value $(index)
function magical_athlete:visual/racer_data with storage magical_athlete:visual racer
data modify storage magical_athlete:direct x set from storage magical_athlete:visual pose.x
data modify storage magical_athlete:direct z set from storage magical_athlete:visual pose.z
data modify storage magical_athlete:direct width set from storage magical_athlete:visual pose.scale
$data modify storage magical_athlete:direct id set value $(index)
data modify storage magical_athlete:direct type set value 2
function magical_athlete:direct/hit_spawn with storage magical_athlete:direct
