$data modify storage magical_athlete:engine chosen set from storage magical_athlete:engine s.pool[$(slot)]
$data remove storage magical_athlete:engine s.pool[$(slot)]
function magical_athlete:engine/draft/add with storage magical_athlete:engine request
scoreboard players set #found ma_ctx 1
