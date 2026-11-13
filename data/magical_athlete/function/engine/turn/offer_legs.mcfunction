function magical_athlete:engine/turn/trip with storage magical_athlete:engine job
execute if score #tripped ma_ctx matches 1 run return 0
data modify storage magical_athlete:engine s.pending set value {"kind":"legs","owner":0,"pawn":-1,"options":[0,1]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
