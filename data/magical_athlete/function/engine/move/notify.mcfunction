execute if data storage magical_athlete:engine s.motion{warp:1} run return 0
execute if data storage magical_athlete:engine s.motion.jumps run function magical_athlete:engine/notify_jumps
execute store result score #source ma_ctx run data get storage magical_athlete:engine s.motion.source
execute if data storage magical_athlete:engine s.motion{group:[0]} if score #p0 ma_ctx matches 33 unless data storage magical_athlete:engine s.motion{pawn:0} run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":0}
execute if data storage magical_athlete:engine s.motion{group:[1]} if score #p1 ma_ctx matches 33 unless data storage magical_athlete:engine s.motion{pawn:1} run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":1}
execute if data storage magical_athlete:engine s.motion{group:[2]} if score #p2 ma_ctx matches 33 unless data storage magical_athlete:engine s.motion{pawn:2} run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":2}
execute if data storage magical_athlete:engine s.motion{group:[3]} if score #p3 ma_ctx matches 33 unless data storage magical_athlete:engine s.motion{pawn:3} run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":3}
execute if data storage magical_athlete:engine s.motion{group:[4]} if score #p4 ma_ctx matches 33 unless data storage magical_athlete:engine s.motion{pawn:4} run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":4}
execute if data storage magical_athlete:engine s.motion{group:[5]} if score #p5 ma_ctx matches 33 unless data storage magical_athlete:engine s.motion{pawn:5} run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":5}
execute unless score #source ma_ctx matches 0..35 run return 0
execute if score #source ma_ctx matches 5 run return 0
execute if score #source ma_ctx matches 26 run return 0
execute if score #source ma_ctx matches 20 run return 0
execute store result score #author ma_ctx run data get storage magical_athlete:engine s.motion.author
execute if score #author ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":0}
execute if score #author ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":1}
execute if score #author ma_ctx matches 2 run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":2}
execute if score #author ma_ctx matches 3 run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":3}
execute if score #author ma_ctx matches 4 run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":4}
execute if score #author ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":5}
