data modify storage magical_athlete:engine motion_signature.sig set value {motion:{},racers:[]}
data modify storage magical_athlete:engine motion_signature.sig.motion set from storage magical_athlete:engine s.motion
data modify storage magical_athlete:engine motion_signature.sig.racers set from storage magical_athlete:engine s.racers
function magical_athlete:engine/motion_match with storage magical_athlete:engine motion_signature
execute if score #motion_repeat ma_ctx matches 1 run return 0
data modify storage magical_athlete:engine s.seen append from storage magical_athlete:engine motion_signature.sig
