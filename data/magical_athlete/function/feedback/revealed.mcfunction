$data modify storage magical_athlete:feedback character set from storage magical_athlete:characters chars[$(char)]
$data modify storage magical_athlete:feedback character.actor set value $(owner)
function magical_athlete:feedback/reveal_text with storage magical_athlete:feedback character
