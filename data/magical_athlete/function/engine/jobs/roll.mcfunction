function magical_athlete:engine/active_context
function magical_athlete:engine/turn/trip with storage magical_athlete:engine job
execute if score #tripped ma_ctx matches 1 run return 0
function magical_athlete:engine/active_context
execute store result storage magical_athlete:engine s.dice int 1 run random value 1..6
function magical_athlete:engine/roll_offer
