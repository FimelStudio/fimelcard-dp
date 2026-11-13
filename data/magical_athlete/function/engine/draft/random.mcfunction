execute unless data storage magical_athlete:engine s.pool[0] run return 0
function magical_athlete:engine/cache
data modify storage magical_athlete:engine request.actor set from storage magical_athlete:engine s.turn
data modify storage magical_athlete:engine chosen set from storage magical_athlete:engine s.pool[0]
data remove storage magical_athlete:engine s.pool[0]
function magical_athlete:engine/draft/add with storage magical_athlete:engine request
function magical_athlete:engine/draft/advance
execute if data storage magical_athlete:engine s{phase:1} if data storage magical_athlete:engine s.pool[0] run function magical_athlete:engine/draft/random
