function magical_athlete:input/context
execute unless entity @s[tag=ma.actor] run return 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless score @s ma_depoch = @e[tag=ma.current,limit=1] ma_epoch run function magical_athlete:direct/rebuild
function magical_athlete:direct/dice_sync
