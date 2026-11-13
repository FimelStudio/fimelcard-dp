data modify storage magical_athlete:engine job set value {type:"points",pawn:0,amount:1,source:22}
data modify storage magical_athlete:engine job.pawn set from storage magical_athlete:engine s.active
function magical_athlete:engine/jobs/points with storage magical_athlete:engine job
data modify storage magical_athlete:engine job set value {pawn:0}
data modify storage magical_athlete:engine job.pawn set from storage magical_athlete:engine s.active
function magical_athlete:engine/jobs/power with storage magical_athlete:engine job
