data modify storage magical_athlete:engine s.pending set value {"kind":"egg","owner":0,"pawn":-1,"options":[]}
execute store result storage magical_athlete:engine s.pending.owner int 1 run scoreboard players get #owner ma_ctx
execute store result storage magical_athlete:engine s.pending.pawn int 1 run scoreboard players get #i ma_ctx
execute if data storage magical_athlete:engine s.deck[0] run data modify storage magical_athlete:engine s.pending.options append from storage magical_athlete:engine s.deck[0]
execute if data storage magical_athlete:engine s.deck[0] run data remove storage magical_athlete:engine s.deck[0]
execute if data storage magical_athlete:engine s.deck[0] run data modify storage magical_athlete:engine s.pending.options append from storage magical_athlete:engine s.deck[0]
execute if data storage magical_athlete:engine s.deck[0] run data remove storage magical_athlete:engine s.deck[0]
execute if data storage magical_athlete:engine s.deck[0] run data modify storage magical_athlete:engine s.pending.options append from storage magical_athlete:engine s.deck[0]
execute if data storage magical_athlete:engine s.deck[0] run data remove storage magical_athlete:engine s.deck[0]
