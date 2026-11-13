data modify storage magical_athlete:engine signature.sig set value {event:{},racers:[]}
data modify storage magical_athlete:engine signature.sig.event set from storage magical_athlete:engine job
data modify storage magical_athlete:engine signature.sig.racers set from storage magical_athlete:engine s.racers
function magical_athlete:engine/cycle/match with storage magical_athlete:engine signature
execute if score #repeated ma_ctx matches 1 run return 0
data modify storage magical_athlete:engine s.seen append from storage magical_athlete:engine signature.sig
