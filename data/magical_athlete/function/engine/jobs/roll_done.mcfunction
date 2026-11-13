function magical_athlete:engine/active_context
execute store result score #die ma_ctx run data get storage magical_athlete:engine s.dice
execute store result score #prediction ma_ctx run data get storage magical_athlete:engine s.prediction
execute if score #power ma_ctx matches 12 if score #prediction ma_ctx = #die ma_ctx run data modify storage magical_athlete:engine s.extra set from storage magical_athlete:engine s.active
execute if score #power ma_ctx matches 12 if score #prediction ma_ctx = #die ma_ctx run function magical_athlete:engine/notify_active
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.next_override set value 0
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 0 run data modify storage magical_athlete:engine s.skip set value 1
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":0,"amount":1,"source":18}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":0,"amount":2,"source":19}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.next_override set value 1
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 1 run data modify storage magical_athlete:engine s.skip set value 1
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":1,"amount":1,"source":18}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":1,"amount":2,"source":19}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.next_override set value 2
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 2 run data modify storage magical_athlete:engine s.skip set value 1
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 2 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":2,"amount":1,"source":18}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches 2 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":2,"amount":2,"source":19}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.next_override set value 3
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 3 run data modify storage magical_athlete:engine s.skip set value 1
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 3 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":3,"amount":1,"source":18}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches 3 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":3,"amount":2,"source":19}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.next_override set value 4
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 4 run data modify storage magical_athlete:engine s.skip set value 1
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 4 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":4,"amount":1,"source":18}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches 4 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":4,"amount":2,"source":19}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.next_override set value 5
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 5 run data modify storage magical_athlete:engine s.skip set value 1
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 18 if score #die ma_ctx matches 1 unless score #i ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":5,"amount":1,"source":18}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 19 if score #die ma_ctx matches 6 unless score #i ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":5,"amount":2,"source":19}
execute if score #power ma_ctx matches 30 if score #die ma_ctx matches 6 run function magical_athlete:engine/turn/sisyphus
data modify storage magical_athlete:engine s.queue append value {"type":"main"}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":0}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":1}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":2}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":3}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":4}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 31 if score #die ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":5}
execute if score #power ma_ctx matches 30 if score #die ma_ctx matches 6 run function magical_athlete:engine/notify_active
