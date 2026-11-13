$data modify storage magical_athlete:direct pawn set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(id)]
data modify storage magical_athlete:direct id set from storage magical_athlete:direct pawn.char
execute store result score #read_power ma_ctx run data get storage magical_athlete:direct pawn.power
execute if score #read_power ma_ctx matches 0..35 run data modify storage magical_athlete:direct id set from storage magical_athlete:direct pawn.power
function magical_athlete:direct/roster_info with storage magical_athlete:direct
