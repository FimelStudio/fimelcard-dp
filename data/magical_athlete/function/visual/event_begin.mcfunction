execute unless data entity @s data.magical_athlete.visual_queue[0] run return run function magical_athlete:game/after_animation
data modify entity @s data.magical_athlete.visual_event set from entity @s data.magical_athlete.visual_queue[0]
data remove entity @s data.magical_athlete.visual_queue[0]
data modify storage magical_athlete:visual event set from entity @s data.magical_athlete.visual_event
scoreboard players set @s ma_vtimer 12
execute if score @s ma_speed matches 1 run scoreboard players set @s ma_vtimer 6
scoreboard players set @s ma_vframe 0
function magical_athlete:visual/event_sound with storage magical_athlete:visual event
function magical_athlete:visual/event_prop with storage magical_athlete:visual event
function magical_athlete:visual/event_announce with storage magical_athlete:visual event
