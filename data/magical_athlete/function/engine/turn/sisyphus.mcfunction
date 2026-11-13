data modify storage magical_athlete:engine s.skip set value 1
data modify storage magical_athlete:engine add set value {type:"warp",pawn:0,to:0,source:30}
data modify storage magical_athlete:engine add.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.queue append from storage magical_athlete:engine add
data modify storage magical_athlete:engine add set value {type:"points",pawn:0,amount:-1,source:30}
data modify storage magical_athlete:engine add.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.queue append from storage magical_athlete:engine add
