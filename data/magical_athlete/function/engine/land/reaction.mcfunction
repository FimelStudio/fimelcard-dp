data modify storage magical_athlete:engine reaction set from storage magical_athlete:engine landed
data modify storage magical_athlete:engine reaction.type set value "react"
$data modify storage magical_athlete:engine reaction.reactor set value $(reactor)
data modify storage magical_athlete:engine s.queue prepend from storage magical_athlete:engine reaction
