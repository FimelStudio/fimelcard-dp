execute if score #reactor ma_ctx = #mover ma_ctx run function magical_athlete:engine/react/baba_moving with storage magical_athlete:engine job
execute if score #reactor ma_ctx = #mover ma_ctx run return 0
execute if score #joint ma_ctx matches 1 run return 0
execute unless score #rpos ma_ctx = #to ma_ctx run return 0
$data modify storage magical_athlete:engine s.queue prepend value {"type":"trip","pawn":$(pawn),"source":1}
$data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":$(reactor)}
