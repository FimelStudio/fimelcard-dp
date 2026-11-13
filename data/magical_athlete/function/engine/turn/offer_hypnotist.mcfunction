data modify storage magical_athlete:engine s.pending set value {"kind":"hypnotist","owner":0,"pawn":-1,"options":[-1]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
execute unless score #i ma_ctx matches 0 if score #s0 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 0
execute unless score #i ma_ctx matches 1 if score #s1 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 1
execute unless score #i ma_ctx matches 2 if score #s2 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 2
execute unless score #i ma_ctx matches 3 if score #s3 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 3
execute unless score #i ma_ctx matches 4 if score #s4 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 4
execute unless score #i ma_ctx matches 5 if score #s5 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 5
