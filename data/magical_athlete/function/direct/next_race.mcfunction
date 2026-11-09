function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
scoreboard players set #code ma_ctx 5
function magical_athlete:direct/submit
