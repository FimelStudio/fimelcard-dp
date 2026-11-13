$data modify storage magical_athlete:engine s.racers[$(pawn)].power set from storage magical_athlete:engine request.target
$data modify storage magical_athlete:engine job set value {type:"prerace",pawn:$(pawn),inherited:1}
function magical_athlete:engine/powers
function magical_athlete:engine/jobs/prerace with storage magical_athlete:engine job
