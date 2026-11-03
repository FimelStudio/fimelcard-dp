execute if score @s ct_paused matches 1 run return run function magical_athlete:engine/error {id:13}
function magical_athlete:engine/context
execute if data storage magical_athlete:engine s.pending.options[0] run return 0
execute unless data storage magical_athlete:engine s.queue[0] run return 0
data modify storage magical_athlete:engine s.events set value []
function magical_athlete:engine/drain
function magical_athlete:engine/advance_epoch
function magical_athlete:engine/commit
