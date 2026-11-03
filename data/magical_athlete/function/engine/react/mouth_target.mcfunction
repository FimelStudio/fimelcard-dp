$execute if data storage magical_athlete:engine job{group:[$(victim)]} run return 0
$data modify storage magical_athlete:engine s.racers[$(victim)].status set value 2
$data modify storage magical_athlete:engine s.eliminated append value $(victim)
$data modify storage magical_athlete:engine s.events append value {kind:5,pawn:$(victim),from:0,to:0,source:25,amount:0,die:0}
data modify storage magical_athlete:engine mouth_notify set value {type:"power",pawn:0}
data modify storage magical_athlete:engine mouth_notify.pawn set from storage magical_athlete:engine job.reactor
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine mouth_notify
function magical_athlete:engine/race/survivor
