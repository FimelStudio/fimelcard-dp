function magical_athlete:engine/react/count
execute unless score #count ma_ctx matches 1 run return 0
execute store result storage magical_athlete:engine s.victim int 1 run scoreboard players get #victim ma_ctx
function magical_athlete:engine/react/romantic_target with storage magical_athlete:engine s
