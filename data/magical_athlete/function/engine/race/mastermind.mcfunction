function magical_athlete:engine/powers
data modify storage magical_athlete:engine winner.pawn set from storage magical_athlete:engine s.finishers[0]
scoreboard players set #master ma_ctx -1
execute store result score #pred ma_ctx run data get storage magical_athlete:engine s.racers[0].prediction
execute store result score #won ma_ctx run data get storage magical_athlete:engine s.finishers[0]
execute unless score #s0 ma_ctx matches 2 if score #p0 ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx 0
execute store result score #pred ma_ctx run data get storage magical_athlete:engine s.racers[1].prediction
execute store result score #won ma_ctx run data get storage magical_athlete:engine s.finishers[0]
execute unless score #s1 ma_ctx matches 2 if score #p1 ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx 1
execute store result score #pred ma_ctx run data get storage magical_athlete:engine s.racers[2].prediction
execute store result score #won ma_ctx run data get storage magical_athlete:engine s.finishers[0]
execute unless score #s2 ma_ctx matches 2 if score #p2 ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx 2
execute store result score #pred ma_ctx run data get storage magical_athlete:engine s.racers[3].prediction
execute store result score #won ma_ctx run data get storage magical_athlete:engine s.finishers[0]
execute unless score #s3 ma_ctx matches 2 if score #p3 ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx 3
execute store result score #pred ma_ctx run data get storage magical_athlete:engine s.racers[4].prediction
execute store result score #won ma_ctx run data get storage magical_athlete:engine s.finishers[0]
execute unless score #s4 ma_ctx matches 2 if score #p4 ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx 4
execute store result score #pred ma_ctx run data get storage magical_athlete:engine s.racers[5].prediction
execute store result score #won ma_ctx run data get storage magical_athlete:engine s.finishers[0]
execute unless score #s5 ma_ctx matches 2 if score #p5 ma_ctx matches 24 if score #pred ma_ctx = #won ma_ctx run scoreboard players set #master ma_ctx 5
execute if score #master ma_ctx matches 0 run function magical_athlete:engine/race/master_award {pawn:0}
execute if score #master ma_ctx matches 1 run function magical_athlete:engine/race/master_award {pawn:1}
execute if score #master ma_ctx matches 2 run function magical_athlete:engine/race/master_award {pawn:2}
execute if score #master ma_ctx matches 3 run function magical_athlete:engine/race/master_award {pawn:3}
execute if score #master ma_ctx matches 4 run function magical_athlete:engine/race/master_award {pawn:4}
execute if score #master ma_ctx matches 5 run function magical_athlete:engine/race/master_award {pawn:5}
