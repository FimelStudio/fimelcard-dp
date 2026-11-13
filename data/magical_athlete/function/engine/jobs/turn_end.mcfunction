function magical_athlete:engine/active_context
execute store result score #start ma_ctx run data get storage magical_athlete:engine s.start_pos
scoreboard players operation #delta ma_ctx = #position ma_ctx
scoreboard players operation #delta ma_ctx -= #start ma_ctx
data modify storage magical_athlete:engine s.queue append value {"type":"advance"}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":5,"amount":2,"source":15}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":4,"amount":2,"source":15}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":3,"amount":2,"source":15}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":2,"amount":2,"source":15}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":1,"amount":2,"source":15}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 15 if score #delta ma_ctx matches -1..1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":0,"amount":2,"source":15}
