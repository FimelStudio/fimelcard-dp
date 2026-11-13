$data modify storage magical_athlete:engine s.finishers append value $(pawn)
$data modify storage magical_athlete:engine job set value {type:"points",pawn:$(pawn),amount:0,source:24}
data modify storage magical_athlete:engine job.amount set from storage magical_athlete:engine s.round
function magical_athlete:engine/jobs/points with storage magical_athlete:engine job
