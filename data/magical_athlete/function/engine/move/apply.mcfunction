$data modify storage magical_athlete:engine s.racers[$(pawn)].pos set from storage magical_athlete:engine s.motion.to
$execute if data storage magical_athlete:engine s.motion.targets[$(pawn)] run data modify storage magical_athlete:engine s.racers[$(pawn)].pos set from storage magical_athlete:engine s.motion.targets[$(pawn)]
$data modify storage magical_athlete:engine e set value {kind:1,pawn:$(pawn),from:0,to:0,source:-2,amount:0,die:0}
$data modify storage magical_athlete:engine e.from set from storage magical_athlete:engine s.motion.before[$(pawn)]
$data modify storage magical_athlete:engine e.to set from storage magical_athlete:engine s.racers[$(pawn)].pos
data modify storage magical_athlete:engine e.source set from storage magical_athlete:engine s.motion.source
execute if data storage magical_athlete:engine s.motion{warp:1} run data modify storage magical_athlete:engine e.kind set value 2
data modify storage magical_athlete:engine s.events append from storage magical_athlete:engine e
