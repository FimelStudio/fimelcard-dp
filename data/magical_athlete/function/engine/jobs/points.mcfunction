function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
$scoreboard players set #amount ma_ctx $(amount)
function magical_athlete:engine/points/owner with storage magical_athlete:engine job
$data modify storage magical_athlete:engine s.events append value {kind:7,pawn:$(pawn),from:0,to:0,source:$(source),amount:$(amount),die:0}
data modify storage magical_athlete:engine s.events[-1].source_actor set from storage magical_athlete:engine job.source_actor
