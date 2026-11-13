$data modify storage magical_athlete:engine append set value {type:"warp",pawn:$(pawn),to:0,source:34}
data modify storage magical_athlete:engine append.to set from storage magical_athlete:engine request.target
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine append
