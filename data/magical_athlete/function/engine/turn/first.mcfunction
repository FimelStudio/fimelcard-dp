$execute store result score #first ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].first
$data modify storage magical_athlete:engine s.racers[$(pawn)].first set value 0
execute if score #first ma_ctx matches 1 if score #power ma_ctx matches 24 run function magical_athlete:engine/turn/mastermind
