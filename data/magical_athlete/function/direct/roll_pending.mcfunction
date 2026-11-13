data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
execute unless data storage magical_athlete:ui pending{kind:"ready"} run return run function magical_athlete:direct/pending_note
execute store result score #code ma_ctx run data get storage magical_athlete:ui pending.options[0]
scoreboard players add #code ma_ctx 2100
function magical_athlete:direct/submit
