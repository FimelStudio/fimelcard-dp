$data modify storage magical_athlete:engine hook set value {type:"land",pawn:$(pawn),from:0,to:0,source:-2,group:[],before:[],moved:1}
$data modify storage magical_athlete:engine hook.from set from storage magical_athlete:engine s.motion.before[$(pawn)]
$data modify storage magical_athlete:engine hook.to set from storage magical_athlete:engine s.racers[$(pawn)].pos
data modify storage magical_athlete:engine hook.source set from storage magical_athlete:engine s.motion.source
data modify storage magical_athlete:engine hook.group set from storage magical_athlete:engine s.motion.group
data modify storage magical_athlete:engine hook.before set from storage magical_athlete:engine s.motion.before
execute if data storage magical_athlete:engine s.motion{warp:1} run data modify storage magical_athlete:engine hook.moved set value 0
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine hook
