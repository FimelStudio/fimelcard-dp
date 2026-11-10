function magical_athlete:engine/active_context
data modify storage magical_athlete:engine s.motion set value {pawn:0,from:0,to:0,source:0,group:[],before:[],targets:[]}
data modify storage magical_athlete:engine s.motion.source_actor set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.motion.pawn set from storage magical_athlete:engine s.active
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
data modify storage magical_athlete:engine s.motion.source set value 5
scoreboard players set #last ma_ctx 31
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x0 ma_ctx
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x1 ma_ctx
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x2 ma_ctx
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x3 ma_ctx
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x4 ma_ctx
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x5 ma_ctx
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #last ma_ctx run function magical_athlete:engine/batch/cheer_one {pawn:0}
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #last ma_ctx run function magical_athlete:engine/batch/cheer_one {pawn:1}
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #last ma_ctx run function magical_athlete:engine/batch/cheer_one {pawn:2}
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #last ma_ctx run function magical_athlete:engine/batch/cheer_one {pawn:3}
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #last ma_ctx run function magical_athlete:engine/batch/cheer_one {pawn:4}
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #last ma_ctx run function magical_athlete:engine/batch/cheer_one {pawn:5}
data modify storage magical_athlete:engine add set value {type:"move",pawn:0,amount:1,source:5}
data modify storage magical_athlete:engine add.pawn set from storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine add
data modify storage magical_athlete:engine s.queue prepend value {"type":"postmove"}
function magical_athlete:engine/notify_active
