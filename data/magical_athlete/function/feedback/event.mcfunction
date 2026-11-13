$data modify storage magical_athlete:feedback event set value {kind:$(kind),pawn:$(pawn),from:$(from),to:$(to),source:$(source),amount:$(amount),die:$(die),source_actor:-1}
data modify storage magical_athlete:feedback event.source_actor set from entity @s data.magical_athlete.visual_event.source_actor
$data modify storage magical_athlete:feedback racer set from entity @s data.magical_athlete.racers[$(pawn)]
execute if data storage magical_athlete:feedback racer{char:-1} run return 0
function magical_athlete:feedback/event_name with storage magical_athlete:feedback racer
function magical_athlete:feedback/event_text with storage magical_athlete:feedback event
