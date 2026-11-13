data modify storage magical_athlete:engine s.pending set value {"kind":"mastermind","owner":0,"pawn":-1,"options":[]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
execute if score #s0 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 0
execute if score #s1 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 1
execute if score #s2 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 2
execute if score #s3 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 3
execute if score #s4 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 4
execute if score #s5 ma_ctx matches 0 run data modify storage magical_athlete:engine s.pending.options append value 5
