scoreboard players set #name_exists ma_ctx 0
$execute if entity @e[tag=ma.racer_name,scores={ct_id=$(table),ma_vid=$(index)}] run scoreboard players set #name_exists ma_ctx 1
$execute if score #name_exists ma_ctx matches 1 as @e[tag=ma.racer_name,scores={ct_id=$(table),ma_vid=$(index)}] run function magical_athlete:visual/name_init with storage magical_athlete:visual
execute if score #name_exists ma_ctx matches 0 positioned ~ ~1.04 ~ summon minecraft:text_display run function magical_athlete:visual/name_init with storage magical_athlete:visual
