execute if data storage magical_athlete:engine s{phase:4} run return 0
data modify storage magical_athlete:engine s.phase set value 4
data modify storage magical_athlete:engine s.queue set value []
data modify storage magical_athlete:engine s.pending set value {kind:"",owner:0,pawn:-1,options:[]}
data modify storage magical_athlete:engine s.active set value -1
data modify storage magical_athlete:engine s.pawn set value -1
data modify storage magical_athlete:engine index.pawn set from storage magical_athlete:engine s.finishers[0]
function magical_athlete:engine/race/history with storage magical_athlete:engine index
function magical_athlete:engine/race/next_starter
execute store result score #round ma_ctx run data get storage magical_athlete:engine s.round
execute if score #round ma_ctx matches 4 run function magical_athlete:engine/race/final
