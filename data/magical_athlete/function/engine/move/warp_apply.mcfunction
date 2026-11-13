$data modify storage magical_athlete:engine s.racers[$(pawn)].pos set value $(to)
$data modify storage magical_athlete:engine e set value {kind:2,pawn:$(pawn),from:0,to:$(to),source:$(source),amount:0,die:0}
data modify storage magical_athlete:engine e.from set from storage magical_athlete:engine s.warp_from
data modify storage magical_athlete:engine s.events append from storage magical_athlete:engine e
$data modify storage magical_athlete:engine hook set value {type:"land",pawn:$(pawn),from:0,to:$(to),source:$(source),group:[$(pawn)],before:[],moved:0}
data modify storage magical_athlete:engine hook.from set from storage magical_athlete:engine s.warp_from
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine hook
