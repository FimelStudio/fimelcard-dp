$execute store result score #r_old ma_ctx run data get storage magical_athlete:engine job.before[$(reactor)]
execute unless score #from ma_ctx < #r_old ma_ctx run return 0
execute unless score #to ma_ctx > #r_old ma_ctx run return 0
$data modify storage magical_athlete:engine s.queue prepend value {"type":"trip","pawn":$(pawn),"source":2,"source_actor":$(reactor)}
$data modify storage magical_athlete:engine s.queue prepend value {"type":"power","pawn":$(reactor)}
