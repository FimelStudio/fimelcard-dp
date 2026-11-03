data modify storage magical_athlete:engine s.pending set value {"kind":"genius","owner":0,"pawn":-1,"options":[0,1,2,3,4,5,6]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
