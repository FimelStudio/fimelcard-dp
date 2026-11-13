$data modify storage magical_athlete:direct cell set value {table:$(table),epoch:$(epoch),type:3,id:0}
$data modify storage magical_athlete:direct cell.id set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(id)].pos
function magical_athlete:direct/use with storage magical_athlete:direct cell
