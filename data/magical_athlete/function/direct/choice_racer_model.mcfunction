$data modify storage magical_athlete:ui model_racer set from entity @e[tag=ma.current,limit=1] data.magical_athlete.racers[$(target)]
function magical_athlete:direct/choice_racer_character with storage magical_athlete:ui model_racer
