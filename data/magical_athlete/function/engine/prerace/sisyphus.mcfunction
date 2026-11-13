$data modify storage magical_athlete:engine job set value {type:"points",pawn:$(pawn),amount:4,source:30}
function magical_athlete:engine/jobs/points with storage magical_athlete:engine job
$data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":$(pawn)}
