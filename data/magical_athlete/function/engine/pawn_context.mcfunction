execute store result score #i ma_ctx run data get storage magical_athlete:engine job.pawn
$execute store result score #owner ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].owner
$execute store result score #power ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].power
$execute store result score #position ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].pos
$execute store result score #status ma_ctx run data get storage magical_athlete:engine s.racers[$(pawn)].status
execute if score #i ma_ctx matches 0 run scoreboard players operation #power ma_ctx = #p0 ma_ctx
execute if score #i ma_ctx matches 1 run scoreboard players operation #power ma_ctx = #p1 ma_ctx
execute if score #i ma_ctx matches 2 run scoreboard players operation #power ma_ctx = #p2 ma_ctx
execute if score #i ma_ctx matches 3 run scoreboard players operation #power ma_ctx = #p3 ma_ctx
execute if score #i ma_ctx matches 4 run scoreboard players operation #power ma_ctx = #p4 ma_ctx
execute if score #i ma_ctx matches 5 run scoreboard players operation #power ma_ctx = #p5 ma_ctx
