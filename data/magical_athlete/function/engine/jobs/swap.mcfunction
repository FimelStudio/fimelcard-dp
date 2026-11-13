function magical_athlete:engine/active_context
data modify storage magical_athlete:engine s.motion set value {pawn:0,from:0,to:0,source:11,author:0,warp:1,group:[],before:[],targets:[]}
data modify storage magical_athlete:engine s.motion.source_actor set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.motion.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.motion.author set from storage magical_athlete:engine s.active
execute store result storage magical_athlete:engine s.motion.from int 1 run scoreboard players get #position ma_ctx
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[0].pos
data modify storage magical_athlete:engine s.motion.targets append from storage magical_athlete:engine s.racers[0].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[1].pos
data modify storage magical_athlete:engine s.motion.targets append from storage magical_athlete:engine s.racers[1].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[2].pos
data modify storage magical_athlete:engine s.motion.targets append from storage magical_athlete:engine s.racers[2].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[3].pos
data modify storage magical_athlete:engine s.motion.targets append from storage magical_athlete:engine s.racers[3].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[4].pos
data modify storage magical_athlete:engine s.motion.targets append from storage magical_athlete:engine s.racers[4].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[5].pos
data modify storage magical_athlete:engine s.motion.targets append from storage magical_athlete:engine s.racers[5].pos
data modify storage magical_athlete:engine swap_args.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine swap_args.target set from storage magical_athlete:engine s.swap
function magical_athlete:engine/swap/targets with storage magical_athlete:engine swap_args
function magical_athlete:engine/jobs/postmove
function magical_athlete:engine/notify_active
