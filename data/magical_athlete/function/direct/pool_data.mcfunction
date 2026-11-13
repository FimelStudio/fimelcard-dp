$data modify storage magical_athlete:direct card set from storage magical_athlete:characters chars[$(id)]
data modify storage magical_athlete:direct slug set from storage magical_athlete:direct card.slug
data modify storage magical_athlete:direct name set from storage magical_athlete:direct card.name
data modify storage magical_athlete:direct width set value 0.46
execute if score @s ma_orient matches 1 run function magical_athlete:direct/rotate_pool
function magical_athlete:direct/pool_place with storage magical_athlete:direct
