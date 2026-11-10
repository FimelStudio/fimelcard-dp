function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #status ma_ctx matches 0 run return 0
data modify storage magical_athlete:engine s.motion set value {pawn:0,from:0,to:0,source:-2,author:0,warp:1,group:[],before:[]}
data modify storage magical_athlete:engine s.motion.pawn set from storage magical_athlete:engine job.pawn
data modify storage magical_athlete:engine s.motion.author set from storage magical_athlete:engine job.pawn
execute store result storage magical_athlete:engine s.motion.from int 1 run scoreboard players get #position ma_ctx
data modify storage magical_athlete:engine s.motion.to set from storage magical_athlete:engine job.to
data modify storage magical_athlete:engine s.motion.source set from storage magical_athlete:engine job.source
data modify storage magical_athlete:engine s.motion.source_actor set from storage magical_athlete:engine job.pawn
execute if data storage magical_athlete:engine job.author run data modify storage magical_athlete:engine s.motion.source_actor set from storage magical_athlete:engine job.author
execute if data storage magical_athlete:engine job.source_actor run data modify storage magical_athlete:engine s.motion.source_actor set from storage magical_athlete:engine job.source_actor
$data modify storage magical_athlete:engine s.motion.group append value $(pawn)
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[0].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[1].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[2].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[3].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[4].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[5].pos
function magical_athlete:engine/jobs/postmove
