function magical_athlete:engine/active_context
data modify storage magical_athlete:engine s.motion set value {pawn:0,from:0,to:0,source:0,group:[],before:[],targets:[]}
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
data modify storage magical_athlete:engine s.motion.source set value 26
execute unless score #i ma_ctx matches 0 if score #s0 ma_ctx matches 0 unless score #x0 ma_ctx = #position ma_ctx run function magical_athlete:engine/batch/party_one {pawn:0}
execute unless score #i ma_ctx matches 1 if score #s1 ma_ctx matches 0 unless score #x1 ma_ctx = #position ma_ctx run function magical_athlete:engine/batch/party_one {pawn:1}
execute unless score #i ma_ctx matches 2 if score #s2 ma_ctx matches 0 unless score #x2 ma_ctx = #position ma_ctx run function magical_athlete:engine/batch/party_one {pawn:2}
execute unless score #i ma_ctx matches 3 if score #s3 ma_ctx matches 0 unless score #x3 ma_ctx = #position ma_ctx run function magical_athlete:engine/batch/party_one {pawn:3}
execute unless score #i ma_ctx matches 4 if score #s4 ma_ctx matches 0 unless score #x4 ma_ctx = #position ma_ctx run function magical_athlete:engine/batch/party_one {pawn:4}
execute unless score #i ma_ctx matches 5 if score #s5 ma_ctx matches 0 unless score #x5 ma_ctx = #position ma_ctx run function magical_athlete:engine/batch/party_one {pawn:5}
data modify storage magical_athlete:engine s.queue prepend value {"type":"postmove"}
function magical_athlete:engine/notify_active
