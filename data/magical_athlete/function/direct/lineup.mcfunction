execute store result score #lineup_count ma_ctx run data get storage magical_athlete:ui hand.selected
execute if data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #lineup_count ma_ctx matches 2.. run return 0
execute unless data entity @e[tag=ma.current,limit=1] data.magical_athlete{n:2} if score #lineup_count ma_ctx matches 1.. run return 0
data modify storage magical_athlete:direct options set from storage magical_athlete:ui hand.hand
data modify storage magical_athlete:direct kind set value "lineup"
function magical_athlete:direct/page
