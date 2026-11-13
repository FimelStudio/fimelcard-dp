$data modify storage magical_athlete:direct id set from entity @s data.magical_athlete.pool[$(index)]
$data modify storage magical_athlete:direct x set value $(x)
$data modify storage magical_athlete:direct z set value $(z)
data modify storage magical_athlete:direct type set value 1
function magical_athlete:direct/pool_data with storage magical_athlete:direct
