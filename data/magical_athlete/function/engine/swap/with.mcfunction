$data modify storage magical_athlete:engine swap_target set from storage magical_athlete:engine s.racers[$(target)].pos
data modify storage magical_athlete:engine swap_self set from storage magical_athlete:engine s.active
$data modify storage magical_athlete:engine swap_index set value {target:$(target),pawn:0}
data modify storage magical_athlete:engine swap_index.pawn set from storage magical_athlete:engine s.active
function magical_athlete:engine/swap/apply with storage magical_athlete:engine swap_index
