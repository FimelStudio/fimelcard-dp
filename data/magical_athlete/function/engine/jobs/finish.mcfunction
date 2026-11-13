function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #status ma_ctx matches 0 run return 0
$data modify storage magical_athlete:engine s.racers[$(pawn)].status set value 1
$data modify storage magical_athlete:engine s.racers[$(pawn)].pos set value 30
$data modify storage magical_athlete:engine s.finishers append value $(pawn)
$data modify storage magical_athlete:engine s.events append value {kind:6,pawn:$(pawn),from:30,to:30,source:-2,amount:0,die:0}
execute store result score #finishers ma_ctx run data get storage magical_athlete:engine s.finishers
execute store result storage magical_athlete:engine s.events[-1].amount int 1 run scoreboard players get #finishers ma_ctx
execute store result score #round ma_ctx run data get storage magical_athlete:engine s.round
scoreboard players operation #award ma_ctx = #round ma_ctx
execute if score #finishers ma_ctx matches 1 run scoreboard players add #award ma_ctx 2
$data modify storage magical_athlete:engine job set value {type:"points",pawn:$(pawn),amount:0,source:-2}
execute store result storage magical_athlete:engine job.amount int 1 run scoreboard players get #award ma_ctx
function magical_athlete:engine/jobs/points with storage magical_athlete:engine job
execute if score #finishers ma_ctx matches 1 run function magical_athlete:engine/race/mastermind
execute store result score #finishers ma_ctx run data get storage magical_athlete:engine s.finishers
execute if score #finishers ma_ctx matches 2.. run function magical_athlete:engine/race/end
