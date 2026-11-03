data modify storage magical_athlete:engine s.pending set value {"kind":"twin","owner":0,"pawn":-1,"options":[-1]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
data modify storage magical_athlete:engine s.pending.options append from storage magical_athlete:engine s.history[]
