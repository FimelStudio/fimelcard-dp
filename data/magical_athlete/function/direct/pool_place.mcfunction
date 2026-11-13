$execute unless entity @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] positioned ~$(x) ~1.055 ~$(z) summon minecraft:item_display run function magical_athlete:direct/pool_init with storage magical_athlete:direct
$execute as @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] run tag @s remove ma.outdated
$execute as @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] run data merge entity @s {teleport_duration:3}
$execute as @e[tag=ma.pool,scores={ct_id=$(table),ma_did=$(id)}] run tp @s ~$(x) ~1.055 ~$(z)
$execute positioned ~$(x) ~1.055 ~$(z) summon minecraft:interaction run function magical_athlete:direct/hit_init with storage magical_athlete:direct
$execute unless entity @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] positioned ~$(x) ~1.42 ~$(z) summon minecraft:text_display run function magical_athlete:direct/pool_title with storage magical_athlete:direct
$execute as @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] run tag @s remove ma.outdated
$execute as @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] run data merge entity @s {teleport_duration:3}
$execute as @e[tag=ma.pool_title,scores={ct_id=$(table),ma_did=$(id)}] run tp @s ~$(x) ~1.42 ~$(z)
