data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
data modify storage magical_athlete:direct options set from storage magical_athlete:ui pending.options
data modify storage magical_athlete:direct kind set value "pending"
execute if data storage magical_athlete:ui pending{kind:"genius"} run return run function magical_athlete:direct/genius_page
function magical_athlete:direct/page
execute if data storage magical_athlete:ui pending{kind:"twin"} run function magical_athlete:direct/special_tool with storage magical_athlete:direct
