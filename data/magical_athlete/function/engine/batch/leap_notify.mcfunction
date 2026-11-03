execute unless score #jumped ma_ctx matches 1.. run return 0
$data modify storage magical_athlete:engine s.queue append value {"type":"power","pawn":$(pawn)}
scoreboard players remove #jumped ma_ctx 1
$function magical_athlete:engine/batch/leap_notify {pawn:$(pawn)}
