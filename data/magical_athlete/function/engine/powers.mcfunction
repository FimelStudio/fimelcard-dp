execute store result score #o0 ma_ctx run data get storage magical_athlete:engine s.racers[0].owner
execute store result score #c0 ma_ctx run data get storage magical_athlete:engine s.racers[0].char
execute store result score #p0 ma_ctx run data get storage magical_athlete:engine s.racers[0].power
execute store result score #x0 ma_ctx run data get storage magical_athlete:engine s.racers[0].pos
execute store result score #t0 ma_ctx run data get storage magical_athlete:engine s.racers[0].trip
execute store result score #s0 ma_ctx run data get storage magical_athlete:engine s.racers[0].status
execute store result score #o1 ma_ctx run data get storage magical_athlete:engine s.racers[1].owner
execute store result score #c1 ma_ctx run data get storage magical_athlete:engine s.racers[1].char
execute store result score #p1 ma_ctx run data get storage magical_athlete:engine s.racers[1].power
execute store result score #x1 ma_ctx run data get storage magical_athlete:engine s.racers[1].pos
execute store result score #t1 ma_ctx run data get storage magical_athlete:engine s.racers[1].trip
execute store result score #s1 ma_ctx run data get storage magical_athlete:engine s.racers[1].status
execute store result score #o2 ma_ctx run data get storage magical_athlete:engine s.racers[2].owner
execute store result score #c2 ma_ctx run data get storage magical_athlete:engine s.racers[2].char
execute store result score #p2 ma_ctx run data get storage magical_athlete:engine s.racers[2].power
execute store result score #x2 ma_ctx run data get storage magical_athlete:engine s.racers[2].pos
execute store result score #t2 ma_ctx run data get storage magical_athlete:engine s.racers[2].trip
execute store result score #s2 ma_ctx run data get storage magical_athlete:engine s.racers[2].status
execute store result score #o3 ma_ctx run data get storage magical_athlete:engine s.racers[3].owner
execute store result score #c3 ma_ctx run data get storage magical_athlete:engine s.racers[3].char
execute store result score #p3 ma_ctx run data get storage magical_athlete:engine s.racers[3].power
execute store result score #x3 ma_ctx run data get storage magical_athlete:engine s.racers[3].pos
execute store result score #t3 ma_ctx run data get storage magical_athlete:engine s.racers[3].trip
execute store result score #s3 ma_ctx run data get storage magical_athlete:engine s.racers[3].status
execute store result score #o4 ma_ctx run data get storage magical_athlete:engine s.racers[4].owner
execute store result score #c4 ma_ctx run data get storage magical_athlete:engine s.racers[4].char
execute store result score #p4 ma_ctx run data get storage magical_athlete:engine s.racers[4].power
execute store result score #x4 ma_ctx run data get storage magical_athlete:engine s.racers[4].pos
execute store result score #t4 ma_ctx run data get storage magical_athlete:engine s.racers[4].trip
execute store result score #s4 ma_ctx run data get storage magical_athlete:engine s.racers[4].status
execute store result score #o5 ma_ctx run data get storage magical_athlete:engine s.racers[5].owner
execute store result score #c5 ma_ctx run data get storage magical_athlete:engine s.racers[5].char
execute store result score #p5 ma_ctx run data get storage magical_athlete:engine s.racers[5].power
execute store result score #x5 ma_ctx run data get storage magical_athlete:engine s.racers[5].pos
execute store result score #t5 ma_ctx run data get storage magical_athlete:engine s.racers[5].trip
execute store result score #s5 ma_ctx run data get storage magical_athlete:engine s.racers[5].status
execute if score #p0 ma_ctx matches 7 run function magical_athlete:engine/copy/0
execute if score #p1 ma_ctx matches 7 run function magical_athlete:engine/copy/1
execute if score #p2 ma_ctx matches 7 run function magical_athlete:engine/copy/2
execute if score #p3 ma_ctx matches 7 run function magical_athlete:engine/copy/3
execute if score #p4 ma_ctx matches 7 run function magical_athlete:engine/copy/4
execute if score #p5 ma_ctx matches 7 run function magical_athlete:engine/copy/5
