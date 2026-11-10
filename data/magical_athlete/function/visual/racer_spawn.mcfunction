$data modify storage magical_athlete:visual racer set from entity @s data.magical_athlete.racers[$(index)]
execute if data storage magical_athlete:visual racer{char:-1} run return 0
execute if data storage magical_athlete:visual racer{owner:0} run return 0
$data modify storage magical_athlete:visual racer.index set value $(index)
function magical_athlete:visual/racer_data with storage magical_athlete:visual racer
data modify storage magical_athlete:visual pose.duration set value 2
function magical_athlete:visual/racer_sync with storage magical_athlete:visual
execute if score @s ma_state matches 3..5 run function magical_athlete:visual/name_spawn with storage magical_athlete:visual racer
