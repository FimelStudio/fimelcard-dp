$data modify storage magical_athlete:visual racer set from entity @s data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:visual racer{char:-1} run return 0
execute if data storage magical_athlete:visual racer{owner:0} run return 0
$data modify storage magical_athlete:visual racer.index set value $(index)
function magical_athlete:visual/racer_data with storage magical_athlete:visual racer
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function magical_athlete:visual/racer_init with storage magical_athlete:visual
