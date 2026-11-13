function magical_athlete:engine/active_context
execute store result score #rerolls ma_ctx run data get storage magical_athlete:engine s.rerolls
scoreboard players set #native ma_ctx 0
execute if score #power ma_ctx matches 23 if score #rerolls ma_ctx matches ..1 run scoreboard players set #native ma_ctx 1
execute if score #native ma_ctx matches 1 run scoreboard players add #rerolls ma_ctx 1
execute store result storage magical_athlete:engine s.rerolls int 1 run scoreboard players get #rerolls ma_ctx
scoreboard players set #merchant_pawn ma_ctx -1
execute if score #native ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[0]} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx 0
execute if score #native ma_ctx matches 0 if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[1]} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx 1
execute if score #native ma_ctx matches 0 if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[2]} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx 2
execute if score #native ma_ctx matches 0 if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[3]} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx 3
execute if score #native ma_ctx matches 0 if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[4]} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx 4
execute if score #native ma_ctx matches 0 if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 8 unless data storage magical_athlete:engine s{used_merchants:[5]} if score #merchant_pawn ma_ctx matches -1 run scoreboard players set #merchant_pawn ma_ctx 5
execute if score #native ma_ctx matches 1 run function magical_athlete:engine/notify_active
execute if score #merchant_pawn ma_ctx matches 0 run data modify storage magical_athlete:engine s.used_merchants append value 0
execute if score #merchant_pawn ma_ctx matches 0 unless score #i ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":0,"amount":1,"source":8}
execute if score #merchant_pawn ma_ctx matches 0 if score #i ma_ctx matches 0 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":0}
execute if score #merchant_pawn ma_ctx matches 1 run data modify storage magical_athlete:engine s.used_merchants append value 1
execute if score #merchant_pawn ma_ctx matches 1 unless score #i ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":1,"amount":1,"source":8}
execute if score #merchant_pawn ma_ctx matches 1 if score #i ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":1}
execute if score #merchant_pawn ma_ctx matches 2 run data modify storage magical_athlete:engine s.used_merchants append value 2
execute if score #merchant_pawn ma_ctx matches 2 unless score #i ma_ctx matches 2 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":2,"amount":1,"source":8}
execute if score #merchant_pawn ma_ctx matches 2 if score #i ma_ctx matches 2 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":2}
execute if score #merchant_pawn ma_ctx matches 3 run data modify storage magical_athlete:engine s.used_merchants append value 3
execute if score #merchant_pawn ma_ctx matches 3 unless score #i ma_ctx matches 3 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":3,"amount":1,"source":8}
execute if score #merchant_pawn ma_ctx matches 3 if score #i ma_ctx matches 3 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":3}
execute if score #merchant_pawn ma_ctx matches 4 run data modify storage magical_athlete:engine s.used_merchants append value 4
execute if score #merchant_pawn ma_ctx matches 4 unless score #i ma_ctx matches 4 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":4,"amount":1,"source":8}
execute if score #merchant_pawn ma_ctx matches 4 if score #i ma_ctx matches 4 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":4}
execute if score #merchant_pawn ma_ctx matches 5 run data modify storage magical_athlete:engine s.used_merchants append value 5
execute if score #merchant_pawn ma_ctx matches 5 unless score #i ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue append value {"type":"move","pawn":5,"amount":1,"source":8}
execute if score #merchant_pawn ma_ctx matches 5 if score #i ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":5}
data modify storage magical_athlete:engine s.queue append value {"type":"roll"}
