$data modify storage magical_athlete:feedback event.name set from storage magical_athlete:characters chars[$(char)].name
$data modify storage magical_athlete:feedback event.actor set value $(owner)
$data modify storage magical_athlete:feedback event.ability set from storage magical_athlete:characters chars[$(power)].ability
