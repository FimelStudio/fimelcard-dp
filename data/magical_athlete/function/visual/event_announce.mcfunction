$execute unless predicate {condition:"minecraft:value_check",value:$(kind),range:{min:6,max:9}} run return 0
$data modify storage magical_athlete:visual announcer set from entity @s data.magical_athlete.racers[$(pawn)]
execute if data storage magical_athlete:visual announcer{char:-1} run return 0
function magical_athlete:visual/announcer_name with storage magical_athlete:visual announcer
$data modify storage magical_athlete:visual announcement.kind set value $(kind)
$data modify storage magical_athlete:visual announcement.die set value $(die)
$data modify storage magical_athlete:visual announcement.amount set value $(amount)
function magical_athlete:visual/announcement with storage magical_athlete:visual announcement
