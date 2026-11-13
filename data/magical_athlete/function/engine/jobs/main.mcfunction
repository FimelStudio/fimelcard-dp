function magical_athlete:engine/active_context
execute store result score #skip ma_ctx run data get storage magical_athlete:engine s.skip
execute if score #skip ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"turn_end"}
execute if score #skip ma_ctx matches 1 run return 0
execute store result score #distance ma_ctx run data get storage magical_athlete:engine s.distance
execute store result score #start ma_ctx run data get storage magical_athlete:engine s.start_pos
execute if score #power ma_ctx matches 3 if score #start ma_ctx matches ..14 run scoreboard players add #distance ma_ctx 3
execute if score #power ma_ctx matches 3 if score #start ma_ctx matches 15.. run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 14 run scoreboard players add #distance ma_ctx 2
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 6 if score #x0 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 13 unless score #i ma_ctx matches 0 run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 6 if score #x1 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 13 unless score #i ma_ctx matches 1 run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 6 if score #x2 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 13 unless score #i ma_ctx matches 2 run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 6 if score #x3 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 13 unless score #i ma_ctx matches 3 run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 6 if score #x4 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 13 unless score #i ma_ctx matches 4 run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 6 if score #x5 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 13 unless score #i ma_ctx matches 5 run scoreboard players remove #distance ma_ctx 1
execute if score #power ma_ctx matches 26 unless score #i ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #position ma_ctx run scoreboard players add #distance ma_ctx 1
execute if score #distance ma_ctx matches ..-1 run scoreboard players set #distance ma_ctx 0
data modify storage magical_athlete:engine add set value {type:"move",pawn:0,amount:0,source:-2}
data modify storage magical_athlete:engine add.pawn set from storage magical_athlete:engine s.active
execute store result storage magical_athlete:engine add.amount int 1 run scoreboard players get #distance ma_ctx
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 6 if score #x0 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":0}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 13 unless score #i ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":0}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 6 if score #x1 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":1}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 13 unless score #i ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":1}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 6 if score #x2 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":2}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 13 unless score #i ma_ctx matches 2 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":2}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 6 if score #x3 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":3}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 13 unless score #i ma_ctx matches 3 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":3}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 6 if score #x4 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":4}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 13 unless score #i ma_ctx matches 4 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":4}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 6 if score #x5 ma_ctx = #position ma_ctx run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":5}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 13 unless score #i ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":5}
execute if score #power ma_ctx matches 3 run function magical_athlete:engine/notify_active
execute if score #power ma_ctx matches 14 run function magical_athlete:engine/notify_active
execute if score #power ma_ctx matches 21 if data storage magical_athlete:engine s{dice:0} run function magical_athlete:engine/notify_active
execute if score #power ma_ctx matches 0 if data storage magical_athlete:engine s{transmuted:1} run function magical_athlete:engine/notify_active
execute if score #power ma_ctx matches 27 if data storage magical_athlete:engine s{bomb:1} run function magical_athlete:engine/notify_active
data modify storage magical_athlete:engine s.queue append from storage magical_athlete:engine add
execute store result score #bomb ma_ctx run data get storage magical_athlete:engine s.bomb
execute if score #bomb ma_ctx matches 1 run data modify storage magical_athlete:engine add set value {type:"trip",pawn:0,source:27}
execute if score #bomb ma_ctx matches 1 run data modify storage magical_athlete:engine add.pawn set from storage magical_athlete:engine s.active
execute if score #bomb ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append from storage magical_athlete:engine add
data modify storage magical_athlete:engine s.queue append value {"type":"turn_end"}
