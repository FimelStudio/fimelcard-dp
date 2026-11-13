data modify storage magical_athlete:engine e set value {kind:9,pawn:0,from:0,to:0,source:-2,amount:0,die:0}
data modify storage magical_athlete:engine e.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine e.die set from storage magical_athlete:engine s.dice
data modify storage magical_athlete:engine s.events append from storage magical_athlete:engine e
