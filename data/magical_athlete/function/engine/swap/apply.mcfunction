$data modify storage magical_athlete:engine swap_old set from storage magical_athlete:engine s.racers[$(pawn)].pos
$data modify storage magical_athlete:engine s.racers[$(pawn)].pos set from storage magical_athlete:engine swap_target
$data modify storage magical_athlete:engine s.racers[$(target)].pos set from storage magical_athlete:engine swap_old
$data modify storage magical_athlete:engine e set value {kind:2,pawn:$(pawn),from:0,to:0,source:11,amount:0,die:0}
data modify storage magical_athlete:engine e.from set from storage magical_athlete:engine swap_old
data modify storage magical_athlete:engine e.to set from storage magical_athlete:engine swap_target
data modify storage magical_athlete:engine s.events append from storage magical_athlete:engine e
$data modify storage magical_athlete:engine e.pawn set value $(target)
data modify storage magical_athlete:engine e.from set from storage magical_athlete:engine swap_target
data modify storage magical_athlete:engine e.to set from storage magical_athlete:engine swap_old
data modify storage magical_athlete:engine s.events append from storage magical_athlete:engine e
$data modify storage magical_athlete:engine hook set value {type:"land",pawn:$(target),from:0,to:0,source:11,group:[$(pawn),$(target)],before:[],moved:0}
data modify storage magical_athlete:engine hook.from set from storage magical_athlete:engine swap_target
data modify storage magical_athlete:engine hook.to set from storage magical_athlete:engine swap_old
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine hook
$data modify storage magical_athlete:engine hook.pawn set value $(pawn)
data modify storage magical_athlete:engine hook.from set from storage magical_athlete:engine swap_old
data modify storage magical_athlete:engine hook.to set from storage magical_athlete:engine swap_target
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine hook
