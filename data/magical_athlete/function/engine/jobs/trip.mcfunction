function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #status ma_ctx matches 0 run return 0
$data modify storage magical_athlete:engine s.racers[$(pawn)].trip set value 1
$data modify storage magical_athlete:engine s.events append value {kind:3,pawn:$(pawn),from:0,to:0,source:$(source),amount:0,die:0}
