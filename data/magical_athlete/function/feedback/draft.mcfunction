$data modify storage magical_athlete:feedback character set from storage magical_athlete:characters chars[$(target)]
$data modify storage magical_athlete:feedback character.actor set value $(actor)
function magical_athlete:feedback/drafted with storage magical_athlete:feedback character
