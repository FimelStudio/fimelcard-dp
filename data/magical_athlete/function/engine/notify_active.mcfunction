data modify storage magical_athlete:engine notify set value {type:"power",pawn:0}
data modify storage magical_athlete:engine notify.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.queue append from storage magical_athlete:engine notify
