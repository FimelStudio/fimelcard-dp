$execute unless data storage magical_athlete:direct options[$(index)] run return 0
$data modify storage magical_athlete:direct target set from storage magical_athlete:direct options[$(index)]
execute if data storage magical_athlete:direct {kind:"draft"} run function magical_athlete:direct/character with storage magical_athlete:direct
execute if data storage magical_athlete:direct {kind:"lineup"} run function magical_athlete:direct/character with storage magical_athlete:direct
execute if data storage magical_athlete:direct {kind:"pending"} run function magical_athlete:direct/option with storage magical_athlete:direct
