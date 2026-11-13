$execute if data storage magical_athlete:engine job{group:[$(victim)]} run return 0
data modify storage magical_athlete:engine add set value {type:"move",pawn:0,amount:2,source:28}
data modify storage magical_athlete:engine add.pawn set from storage magical_athlete:engine job.reactor
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine add
