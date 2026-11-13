execute store result storage magical_athlete:feedback id int 1 run scoreboard players get @s ma_vid
data modify storage magical_athlete:feedback x set from entity @s transformation.translation[0]
data modify storage magical_athlete:feedback y set from entity @s transformation.translation[1]
data modify storage magical_athlete:feedback z set from entity @s transformation.translation[2]
function magical_athlete:feedback/target_particle with storage magical_athlete:feedback
