$data modify storage magical_athlete:direct card set from storage magical_athlete:characters chars[$(id)]
data modify storage magical_athlete:direct slug set from storage magical_athlete:direct card.slug
data modify storage magical_athlete:direct name set from storage magical_athlete:direct card.name
data modify storage magical_athlete:direct width set value 0.46
execute if entity @e[tag=ma.current,scores={ma_orient=1},limit=1] run function magical_athlete:direct/rotate_pool
$execute positioned ~$(x) ~1.12 ~$(z) summon minecraft:item_display run function magical_athlete:direct/pool_init with storage magical_athlete:direct
$execute positioned ~$(x) ~1.10 ~$(z) summon minecraft:interaction run function magical_athlete:direct/hit_init with storage magical_athlete:direct
$execute positioned ~$(x) ~1.32 ~$(z) summon minecraft:text_display run function magical_athlete:direct/pool_title with storage magical_athlete:direct
