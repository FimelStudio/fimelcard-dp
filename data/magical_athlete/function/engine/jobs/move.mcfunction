function magical_athlete:engine/pawn_context with storage magical_athlete:engine job
execute unless score #status ma_ctx matches 0 run return 0
$scoreboard players set #amount ma_ctx $(amount)
execute if score #amount ma_ctx matches 0 run return 0
data modify storage magical_athlete:engine s.motion set value {pawn:0,from:0,to:0,source:-2,group:[],before:[]}
data modify storage magical_athlete:engine s.motion.pawn set from storage magical_athlete:engine job.pawn
execute store result storage magical_athlete:engine s.motion.from int 1 run scoreboard players get #position ma_ctx
data modify storage magical_athlete:engine s.motion.source set from storage magical_athlete:engine job.source
data modify storage magical_athlete:engine s.motion.author set from storage magical_athlete:engine job.pawn
execute if data storage magical_athlete:engine job.author run data modify storage magical_athlete:engine s.motion.author set from storage magical_athlete:engine job.author
scoreboard players operation #destination ma_ctx = #position ma_ctx
scoreboard players operation #destination ma_ctx += #amount ma_ctx
execute if score #destination ma_ctx matches ..-1 run scoreboard players set #destination ma_ctx 0
execute if score #power ma_ctx matches 20 run function magical_athlete:engine/move/leap
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 32 unless score #i ma_ctx matches 0 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:0}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 32 unless score #i ma_ctx matches 1 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:1}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 32 unless score #i ma_ctx matches 2 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:2}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 32 unless score #i ma_ctx matches 3 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:3}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 32 unless score #i ma_ctx matches 4 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:4}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 32 unless score #i ma_ctx matches 5 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:5}
execute if score #destination ma_ctx matches 31.. run scoreboard players set #destination ma_ctx 30
execute if score #power ma_ctx matches 20 run data modify storage magical_athlete:engine s.motion.jumps set value 0
execute if score #power ma_ctx matches 20 run execute store result storage magical_athlete:engine s.motion.jumps int 1 run scoreboard players get #jumped ma_ctx
execute store result storage magical_athlete:engine s.motion.to int 1 run scoreboard players get #destination ma_ctx
$data modify storage magical_athlete:engine s.motion.group append value $(pawn)
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[0].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[1].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[2].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[3].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[4].pos
data modify storage magical_athlete:engine s.motion.before append from storage magical_athlete:engine s.racers[5].pos
data modify storage magical_athlete:engine s.queue prepend value {"type":"postmove"}
execute unless score #i ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 33 if score #x5 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"follow","pawn":5}
execute unless score #i ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 33 if score #x4 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"follow","pawn":4}
execute unless score #i ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 33 if score #x3 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"follow","pawn":3}
execute unless score #i ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 33 if score #x2 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"follow","pawn":2}
execute unless score #i ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 33 if score #x1 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"follow","pawn":1}
execute unless score #i ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 33 if score #x0 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"follow","pawn":0}
