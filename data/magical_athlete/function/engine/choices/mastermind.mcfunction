$data modify storage magical_athlete:engine s.racers[$(pawn)].prediction set from storage magical_athlete:engine request.target
data modify storage magical_athlete:engine s.queue append value {"type":"pre"}
