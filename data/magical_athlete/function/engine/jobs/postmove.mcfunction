function magical_athlete:engine/motion_cycle
execute if score #motion_repeat ma_ctx matches 1 run return 0
function magical_athlete:engine/powers
execute if data storage magical_athlete:engine s.motion{group:[0]} run function magical_athlete:engine/move/apply {pawn:0}
execute if data storage magical_athlete:engine s.motion{group:[1]} run function magical_athlete:engine/move/apply {pawn:1}
execute if data storage magical_athlete:engine s.motion{group:[2]} run function magical_athlete:engine/move/apply {pawn:2}
execute if data storage magical_athlete:engine s.motion{group:[3]} run function magical_athlete:engine/move/apply {pawn:3}
execute if data storage magical_athlete:engine s.motion{group:[4]} run function magical_athlete:engine/move/apply {pawn:4}
execute if data storage magical_athlete:engine s.motion{group:[5]} run function magical_athlete:engine/move/apply {pawn:5}
function magical_athlete:engine/move/finish_arrivals
execute if data storage magical_athlete:engine s{phase:4} run return 0
execute if data storage magical_athlete:engine s{phase:5} run return 0
function magical_athlete:engine/powers
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 16 if score #x0 ma_ctx matches 1..29 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #x0 ma_ctx run function magical_athlete:engine/move/baby {pawn:1,baby:0}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 16 if score #x0 ma_ctx matches 1..29 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #x0 ma_ctx run function magical_athlete:engine/move/baby {pawn:2,baby:0}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 16 if score #x0 ma_ctx matches 1..29 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #x0 ma_ctx run function magical_athlete:engine/move/baby {pawn:3,baby:0}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 16 if score #x0 ma_ctx matches 1..29 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #x0 ma_ctx run function magical_athlete:engine/move/baby {pawn:4,baby:0}
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 16 if score #x0 ma_ctx matches 1..29 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #x0 ma_ctx run function magical_athlete:engine/move/baby {pawn:5,baby:0}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 16 if score #x1 ma_ctx matches 1..29 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #x1 ma_ctx run function magical_athlete:engine/move/baby {pawn:0,baby:1}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 16 if score #x1 ma_ctx matches 1..29 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #x1 ma_ctx run function magical_athlete:engine/move/baby {pawn:2,baby:1}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 16 if score #x1 ma_ctx matches 1..29 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #x1 ma_ctx run function magical_athlete:engine/move/baby {pawn:3,baby:1}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 16 if score #x1 ma_ctx matches 1..29 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #x1 ma_ctx run function magical_athlete:engine/move/baby {pawn:4,baby:1}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 16 if score #x1 ma_ctx matches 1..29 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #x1 ma_ctx run function magical_athlete:engine/move/baby {pawn:5,baby:1}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 16 if score #x2 ma_ctx matches 1..29 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #x2 ma_ctx run function magical_athlete:engine/move/baby {pawn:0,baby:2}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 16 if score #x2 ma_ctx matches 1..29 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #x2 ma_ctx run function magical_athlete:engine/move/baby {pawn:1,baby:2}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 16 if score #x2 ma_ctx matches 1..29 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #x2 ma_ctx run function magical_athlete:engine/move/baby {pawn:3,baby:2}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 16 if score #x2 ma_ctx matches 1..29 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #x2 ma_ctx run function magical_athlete:engine/move/baby {pawn:4,baby:2}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 16 if score #x2 ma_ctx matches 1..29 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #x2 ma_ctx run function magical_athlete:engine/move/baby {pawn:5,baby:2}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 16 if score #x3 ma_ctx matches 1..29 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #x3 ma_ctx run function magical_athlete:engine/move/baby {pawn:0,baby:3}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 16 if score #x3 ma_ctx matches 1..29 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #x3 ma_ctx run function magical_athlete:engine/move/baby {pawn:1,baby:3}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 16 if score #x3 ma_ctx matches 1..29 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #x3 ma_ctx run function magical_athlete:engine/move/baby {pawn:2,baby:3}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 16 if score #x3 ma_ctx matches 1..29 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #x3 ma_ctx run function magical_athlete:engine/move/baby {pawn:4,baby:3}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 16 if score #x3 ma_ctx matches 1..29 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #x3 ma_ctx run function magical_athlete:engine/move/baby {pawn:5,baby:3}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 16 if score #x4 ma_ctx matches 1..29 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #x4 ma_ctx run function magical_athlete:engine/move/baby {pawn:0,baby:4}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 16 if score #x4 ma_ctx matches 1..29 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #x4 ma_ctx run function magical_athlete:engine/move/baby {pawn:1,baby:4}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 16 if score #x4 ma_ctx matches 1..29 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #x4 ma_ctx run function magical_athlete:engine/move/baby {pawn:2,baby:4}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 16 if score #x4 ma_ctx matches 1..29 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #x4 ma_ctx run function magical_athlete:engine/move/baby {pawn:3,baby:4}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 16 if score #x4 ma_ctx matches 1..29 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #x4 ma_ctx run function magical_athlete:engine/move/baby {pawn:5,baby:4}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 16 if score #x5 ma_ctx matches 1..29 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #x5 ma_ctx run function magical_athlete:engine/move/baby {pawn:0,baby:5}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 16 if score #x5 ma_ctx matches 1..29 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #x5 ma_ctx run function magical_athlete:engine/move/baby {pawn:1,baby:5}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 16 if score #x5 ma_ctx matches 1..29 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #x5 ma_ctx run function magical_athlete:engine/move/baby {pawn:2,baby:5}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 16 if score #x5 ma_ctx matches 1..29 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #x5 ma_ctx run function magical_athlete:engine/move/baby {pawn:3,baby:5}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 16 if score #x5 ma_ctx matches 1..29 if score #s4 ma_ctx matches 0 if score #x4 ma_ctx = #x5 ma_ctx run function magical_athlete:engine/move/baby {pawn:4,baby:5}
execute if data storage magical_athlete:engine s.motion{group:[5]} run function magical_athlete:engine/move/hooks {pawn:5}
execute if data storage magical_athlete:engine s.motion{group:[4]} run function magical_athlete:engine/move/hooks {pawn:4}
execute if data storage magical_athlete:engine s.motion{group:[3]} run function magical_athlete:engine/move/hooks {pawn:3}
execute if data storage magical_athlete:engine s.motion{group:[2]} run function magical_athlete:engine/move/hooks {pawn:2}
execute if data storage magical_athlete:engine s.motion{group:[1]} run function magical_athlete:engine/move/hooks {pawn:1}
execute if data storage magical_athlete:engine s.motion{group:[0]} run function magical_athlete:engine/move/hooks {pawn:0}
function magical_athlete:engine/move/notify
