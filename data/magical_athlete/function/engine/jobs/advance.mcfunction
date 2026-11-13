function magical_athlete:engine/powers
execute store result score #extra ma_ctx run data get storage magical_athlete:engine s.extra
execute store result score #override ma_ctx run data get storage magical_athlete:engine s.next_override
execute store result score #active ma_ctx run data get storage magical_athlete:engine s.active
data modify storage magical_athlete:engine s.forced set value -1
execute if score #extra ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #override ma_ctx matches -1 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #extra ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #override ma_ctx matches -1 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #extra ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #override ma_ctx matches -1 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #extra ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #override ma_ctx matches -1 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #extra ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #override ma_ctx matches -1 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #extra ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #override ma_ctx matches -1 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #override ma_ctx matches 0 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #override ma_ctx matches 1 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #override ma_ctx matches 2 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #override ma_ctx matches 3 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #override ma_ctx matches 4 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #override ma_ctx matches 5 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #active ma_ctx matches 0 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #active ma_ctx matches 0 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #active ma_ctx matches 0 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #active ma_ctx matches 0 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #active ma_ctx matches 0 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #active ma_ctx matches 0 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #active ma_ctx matches 1 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #active ma_ctx matches 1 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #active ma_ctx matches 1 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #active ma_ctx matches 1 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #active ma_ctx matches 1 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #active ma_ctx matches 1 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #active ma_ctx matches 2 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #active ma_ctx matches 2 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #active ma_ctx matches 2 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #active ma_ctx matches 2 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #active ma_ctx matches 2 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #active ma_ctx matches 2 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #active ma_ctx matches 3 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #active ma_ctx matches 3 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #active ma_ctx matches 3 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #active ma_ctx matches 3 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #active ma_ctx matches 3 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #active ma_ctx matches 3 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #active ma_ctx matches 4 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
execute if score #active ma_ctx matches 4 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #active ma_ctx matches 4 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #active ma_ctx matches 4 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #active ma_ctx matches 4 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #active ma_ctx matches 4 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #active ma_ctx matches 5 if score #s0 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:0}
execute if score #active ma_ctx matches 5 if score #s1 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:1}
execute if score #active ma_ctx matches 5 if score #s2 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:2}
execute if score #active ma_ctx matches 5 if score #s3 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:3}
execute if score #active ma_ctx matches 5 if score #s4 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:4}
execute if score #active ma_ctx matches 5 if score #s5 ma_ctx matches 0 run return run function magical_athlete:engine/advance/choose {pawn:5}
function magical_athlete:engine/race/end
