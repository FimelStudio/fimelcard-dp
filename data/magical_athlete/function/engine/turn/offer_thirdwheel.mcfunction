data modify storage magical_athlete:engine s.pending set value {"kind":"thirdwheel","owner":0,"pawn":-1,"options":[-1]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 0 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 0 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 0 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 0 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 0 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 0 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 0
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 1 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 1 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 1 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 1 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 1 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 1 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 1
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 2 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 2 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 2 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 2 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 2 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 2 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 2
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 3 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 3 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 3 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 3 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 3 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 3 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 3
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 4 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 4 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 4 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 4 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 4 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 4 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 4
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 5 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 5 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 5 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 5 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 5 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 5 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 5
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 6 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 6 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 6 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 6 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 6 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 6 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 6
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 7 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 7 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 7 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 7 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 7 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 7 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 7
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 8 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 8 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 8 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 8 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 8 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 8 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 8
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 9 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 9 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 9 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 9 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 9 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 9 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 9
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 10 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 10 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 10 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 10 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 10 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 10 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 10
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 11 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 11 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 11 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 11 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 11 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 11 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 11
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 12 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 12 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 12 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 12 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 12 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 12 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 12
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 13 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 13 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 13 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 13 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 13 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 13 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 13
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 14 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 14 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 14 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 14 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 14 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 14 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 14
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 15 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 15 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 15 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 15 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 15 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 15 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 15
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 16 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 16 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 16 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 16 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 16 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 16 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 16
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 17 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 17 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 17 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 17 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 17 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 17 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 17
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 18 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 18 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 18 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 18 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 18 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 18 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 18
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 19 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 19 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 19 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 19 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 19 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 19 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 19
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 20 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 20 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 20 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 20 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 20 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 20 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 20
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 21 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 21 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 21 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 21 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 21 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 21 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 21
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 22 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 22 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 22 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 22 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 22 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 22 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 22
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 23 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 23 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 23 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 23 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 23 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 23 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 23
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 24 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 24 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 24 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 24 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 24 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 24 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 24
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 25 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 25 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 25 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 25 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 25 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 25 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 25
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 26 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 26 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 26 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 26 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 26 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 26 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 26
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 27 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 27 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 27 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 27 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 27 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 27 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 27
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 28 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 28 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 28 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 28 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 28 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 28 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 28
scoreboard players set #count ma_ctx 0
execute if score #s0 ma_ctx matches 0 if score #x0 ma_ctx matches 29 run scoreboard players add #count ma_ctx 1
execute if score #s1 ma_ctx matches 0 if score #x1 ma_ctx matches 29 run scoreboard players add #count ma_ctx 1
execute if score #s2 ma_ctx matches 0 if score #x2 ma_ctx matches 29 run scoreboard players add #count ma_ctx 1
execute if score #s3 ma_ctx matches 0 if score #x3 ma_ctx matches 29 run scoreboard players add #count ma_ctx 1
execute if score #s4 ma_ctx matches 0 if score #x4 ma_ctx matches 29 run scoreboard players add #count ma_ctx 1
execute if score #s5 ma_ctx matches 0 if score #x5 ma_ctx matches 29 run scoreboard players add #count ma_ctx 1
execute if score #count ma_ctx matches 2 run data modify storage magical_athlete:engine s.pending.options append value 29
