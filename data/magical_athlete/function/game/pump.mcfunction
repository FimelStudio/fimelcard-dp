execute if score @s ct_paused matches 1 run return 0
execute if score @s ma_anim matches 1.. run return 0
execute unless data entity @s data.magical_athlete.queue[0] run return 0
execute if data entity @s data.magical_athlete.pending.options[0] run return 0
scoreboard players operation @s ma_previous = @s ma_state
data modify entity @s data.magical_athlete.visual_before set from entity @s data.magical_athlete.racers
function magical_athlete:engine/pump
execute if score #ok ma_ctx matches 1 run function magical_athlete:game/after_action
