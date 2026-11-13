execute unless data storage magical_athlete:engine s{track:1} run return 0
$execute if score #destination ma_ctx matches 1 run data modify storage magical_athlete:engine s.queue prepend value {"type":"points","pawn":$(pawn),"amount":1,"source":-1}
$execute if score #destination ma_ctx matches 5 run data modify storage magical_athlete:engine s.queue prepend value {"type":"trip","pawn":$(pawn),"source":-1}
$execute if score #destination ma_ctx matches 7 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":$(pawn),"amount":3,"source":-1}
$execute if score #destination ma_ctx matches 11 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":$(pawn),"amount":1,"source":-1}
$execute if score #destination ma_ctx matches 13 run data modify storage magical_athlete:engine s.queue prepend value {"type":"points","pawn":$(pawn),"amount":1,"source":-1}
$execute if score #destination ma_ctx matches 16 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":$(pawn),"amount":-4,"source":-1}
$execute if score #destination ma_ctx matches 17 run data modify storage magical_athlete:engine s.queue prepend value {"type":"trip","pawn":$(pawn),"source":-1}
$execute if score #destination ma_ctx matches 23 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":$(pawn),"amount":2,"source":-1}
$execute if score #destination ma_ctx matches 24 run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":$(pawn),"amount":-2,"source":-1}
$execute if score #destination ma_ctx matches 26 run data modify storage magical_athlete:engine s.queue prepend value {"type":"trip","pawn":$(pawn),"source":-1}
