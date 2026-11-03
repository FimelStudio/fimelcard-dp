$data modify storage magical_athlete:engine s.turn set from storage magical_athlete:engine s.racers[$(pawn)].owner
$data modify storage magical_athlete:engine s.forced set value $(pawn)
data modify storage magical_athlete:engine s.extra set value -1
data modify storage magical_athlete:engine s.next_override set value -1
data modify storage magical_athlete:engine s.racers[0].done set value 0
data modify storage magical_athlete:engine s.racers[1].done set value 0
data modify storage magical_athlete:engine s.racers[2].done set value 0
data modify storage magical_athlete:engine s.racers[3].done set value 0
data modify storage magical_athlete:engine s.racers[4].done set value 0
data modify storage magical_athlete:engine s.racers[5].done set value 0
