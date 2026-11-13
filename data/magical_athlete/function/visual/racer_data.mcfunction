$data modify storage magical_athlete:visual model set from storage magical_athlete:characters chars[$(char)].slug
$data modify storage magical_athlete:visual index set value $(index)
$data modify storage magical_athlete:visual pose set from storage magical_athlete:visual layout.pawns[$(index)][$(pos)]
execute unless data storage magical_athlete:visual racer{status:2} run function magical_athlete:visual/stack_pose with storage magical_athlete:visual racer
$execute if predicate {type:"minecraft:int_value_check",value:$(status),test:2} run data modify storage magical_athlete:visual pose.scale set value 0.001
data modify storage magical_athlete:visual pose.duration set value 0
