function magical_athlete:engine/powers
$scoreboard players set #author ma_ctx $(pawn)
$data modify storage magical_athlete:engine s.events append value {kind:8,pawn:$(pawn),from:0,to:0,source:0,amount:0,die:0}
execute unless score #author ma_ctx matches 5 if score #s5 ma_ctx matches 0 if score #p5 ma_ctx matches 29 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":5,"amount":1,"source":29}
execute unless score #author ma_ctx matches 4 if score #s4 ma_ctx matches 0 if score #p4 ma_ctx matches 29 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":4,"amount":1,"source":29}
execute unless score #author ma_ctx matches 3 if score #s3 ma_ctx matches 0 if score #p3 ma_ctx matches 29 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":3,"amount":1,"source":29}
execute unless score #author ma_ctx matches 2 if score #s2 ma_ctx matches 0 if score #p2 ma_ctx matches 29 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":2,"amount":1,"source":29}
execute unless score #author ma_ctx matches 1 if score #s1 ma_ctx matches 0 if score #p1 ma_ctx matches 29 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":1,"amount":1,"source":29}
execute unless score #author ma_ctx matches 0 if score #s0 ma_ctx matches 0 if score #p0 ma_ctx matches 29 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":0,"amount":1,"source":29}
