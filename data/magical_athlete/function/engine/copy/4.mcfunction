scoreboard players set #lead ma_ctx -1
scoreboard players set #picked ma_ctx -1
execute store result score #copy ma_ctx run data get storage magical_athlete:engine s.racers[4].copy
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x4 ma_ctx
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x0 ma_ctx
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x1 ma_ctx
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x2 ma_ctx
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x3 ma_ctx
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx > #lead ma_ctx run scoreboard players operation #lead ma_ctx = #x5 ma_ctx
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #lead ma_ctx unless score #p0 ma_ctx matches 7 if score #picked ma_ctx matches -1 run scoreboard players set #picked ma_ctx 0
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #lead ma_ctx unless score #p1 ma_ctx matches 7 if score #picked ma_ctx matches -1 run scoreboard players set #picked ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #lead ma_ctx unless score #p2 ma_ctx matches 7 if score #picked ma_ctx matches -1 run scoreboard players set #picked ma_ctx 2
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #lead ma_ctx unless score #p3 ma_ctx matches 7 if score #picked ma_ctx matches -1 run scoreboard players set #picked ma_ctx 3
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #lead ma_ctx unless score #p5 ma_ctx matches 7 if score #picked ma_ctx matches -1 run scoreboard players set #picked ma_ctx 5
execute if score #copy ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #x0 ma_ctx = #lead ma_ctx unless score #p0 ma_ctx matches 7 run scoreboard players set #picked ma_ctx 0
execute if score #copy ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #x1 ma_ctx = #lead ma_ctx unless score #p1 ma_ctx matches 7 run scoreboard players set #picked ma_ctx 1
execute if score #copy ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #x2 ma_ctx = #lead ma_ctx unless score #p2 ma_ctx matches 7 run scoreboard players set #picked ma_ctx 2
execute if score #copy ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #x3 ma_ctx = #lead ma_ctx unless score #p3 ma_ctx matches 7 run scoreboard players set #picked ma_ctx 3
execute if score #copy ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #x5 ma_ctx = #lead ma_ctx unless score #p5 ma_ctx matches 7 run scoreboard players set #picked ma_ctx 5
scoreboard players set #p4 ma_ctx -1
execute if score #picked ma_ctx matches 0 run scoreboard players operation #p4 ma_ctx = #p0 ma_ctx
execute if score #picked ma_ctx matches 1 run scoreboard players operation #p4 ma_ctx = #p1 ma_ctx
execute if score #picked ma_ctx matches 2 run scoreboard players operation #p4 ma_ctx = #p2 ma_ctx
execute if score #picked ma_ctx matches 3 run scoreboard players operation #p4 ma_ctx = #p3 ma_ctx
execute if score #picked ma_ctx matches 4 run scoreboard players operation #p4 ma_ctx = #p4 ma_ctx
execute if score #picked ma_ctx matches 5 run scoreboard players operation #p4 ma_ctx = #p5 ma_ctx
