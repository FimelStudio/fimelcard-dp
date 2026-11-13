$data modify storage magical_athlete:visual info_name set from storage magical_athlete:characters chars[$(char)].name
data modify storage magical_athlete:visual info.extra append value {text:" · ",color:"gray"}
function magical_athlete:visual/info_racer_text with storage magical_athlete:visual
