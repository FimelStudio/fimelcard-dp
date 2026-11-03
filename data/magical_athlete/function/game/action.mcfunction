execute if score @s ct_paused matches 1 run return 0
function magical_athlete:system/context
execute unless entity @a[tag=ma.actor,tag=ma.audience,limit=1] run return 0
execute if score @s ma_anim matches 1.. run return 0
scoreboard players operation @s ma_previous = @s ma_state
data modify entity @s data.magical_athlete.visual_before set from entity @s data.magical_athlete.racers
function magical_athlete:engine/action
execute unless score #ok ma_ctx matches 1 run return run function magical_athlete:game/illegal
function magical_athlete:game/after_action
