$execute store result score #finished_pos ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].pos
$execute store result score #finished_status ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].status
execute unless score #finished_status ma_ctx matches 0 run return 0
execute unless score #finished_pos ma_ctx matches 30.. run return 0
$data modify storage magical_athlete:engine job set value {pawn:$(pawn)}
function magical_athlete:engine/jobs/finish with storage magical_athlete:engine job
