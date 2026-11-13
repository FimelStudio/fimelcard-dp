$data modify storage magical_athlete:visual info_racer set from entity @s data.magical_athlete.racers[$(index)]
$execute unless data storage magical_athlete:visual info_racer{owner:$(side)} run return 0
execute if data storage magical_athlete:visual info_racer{char:-1} run return 0
function magical_athlete:visual/info_racer_name with storage magical_athlete:visual info_racer
