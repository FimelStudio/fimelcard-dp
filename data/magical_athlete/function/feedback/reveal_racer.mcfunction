$data modify storage magical_athlete:feedback racer set from entity @s data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:feedback racer{char:-1} run return 0
function magical_athlete:feedback/revealed with storage magical_athlete:feedback racer
