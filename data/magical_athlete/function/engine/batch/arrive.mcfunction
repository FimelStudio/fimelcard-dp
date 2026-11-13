$scoreboard players set #i ma_ctx $(pawn)
$scoreboard players set #amount ma_ctx $(amount)
$execute store result score #position ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].pos
$scoreboard players operation #power ma_ctx = #p$(pawn) ma_ctx
scoreboard players operation #destination ma_ctx = #position ma_ctx
scoreboard players operation #destination ma_ctx += #amount ma_ctx
execute if score #power ma_ctx matches 20 run function magical_athlete:engine/move/leap
execute if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 32 unless score #i ma_ctx matches 0 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:0}
execute if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 32 unless score #i ma_ctx matches 1 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:1}
execute if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 32 unless score #i ma_ctx matches 2 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:2}
execute if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 32 unless score #i ma_ctx matches 3 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:3}
execute if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 32 unless score #i ma_ctx matches 4 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:4}
execute if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 32 unless score #i ma_ctx matches 5 if score #destination ma_ctx matches 31.. run return run function magical_athlete:engine/stickler_block {pawn:5}
execute if score #destination ma_ctx matches 31.. run scoreboard players set #destination ma_ctx 30
execute if score #destination ma_ctx matches ..-1 run scoreboard players set #destination ma_ctx 0
$execute store result storage magical_athlete:engine s.motion.targets[$(pawn)] int 1 run scoreboard players get #destination ma_ctx
$data modify storage magical_athlete:engine s.motion.group append value $(pawn)
$execute if score #power ma_ctx matches 20 run function magical_athlete:engine/batch/leap_notify {pawn:$(pawn)}
