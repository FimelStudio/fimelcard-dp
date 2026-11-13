function magical_athlete:engine/powers
scoreboard players set #last ma_ctx 31
scoreboard players set #starter ma_ctx 1
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o0 ma_ctx
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x0 ma_ctx
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o1 ma_ctx
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x1 ma_ctx
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o2 ma_ctx
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x2 ma_ctx
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o3 ma_ctx
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x3 ma_ctx
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o4 ma_ctx
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x4 ma_ctx
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx < #last ma_ctx run scoreboard players operation #starter ma_ctx = #o5 ma_ctx
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx < #last ma_ctx run scoreboard players operation #last ma_ctx = #x5 ma_ctx
execute if data storage magical_athlete:engine s.eliminated[0] run data modify storage magical_athlete:engine eliminated.index set from storage magical_athlete:engine s.eliminated[0]
execute if data storage magical_athlete:engine s.eliminated[0] run function magical_athlete:engine/race/eliminated_starter with storage magical_athlete:engine eliminated
execute store result score #points1 ma_ctx run data get storage magical_athlete:engine s.p1.race_points
execute store result score #points2 ma_ctx run data get storage magical_athlete:engine s.p2.race_points
execute if score #n ma_ctx matches 2 if score #points1 ma_ctx < #points2 ma_ctx run scoreboard players set #starter ma_ctx 1
execute if score #n ma_ctx matches 2 if score #points2 ma_ctx < #points1 ma_ctx run scoreboard players set #starter ma_ctx 2
execute if score #n ma_ctx matches 2 if score #points1 ma_ctx = #points2 ma_ctx run function magical_athlete:engine/rolloff
execute if score #n ma_ctx matches 2 if score #points1 ma_ctx = #points2 ma_ctx run scoreboard players operation #starter ma_ctx = #winner ma_ctx
execute store result storage magical_athlete:engine s.turn int 1 run scoreboard players get #starter ma_ctx
