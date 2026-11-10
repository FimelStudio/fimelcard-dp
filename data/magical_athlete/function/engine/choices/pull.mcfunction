data modify storage magical_athlete:engine append set value {type:"warp",pawn:0,to:0,source:17}
data modify storage magical_athlete:engine append.pawn set from storage magical_athlete:engine request.target
$data modify storage magical_athlete:engine append.to set from storage magical_athlete:engine s.racers[$(pawn)].pos
$data modify storage magical_athlete:engine append.source_actor set value $(pawn)
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine append
