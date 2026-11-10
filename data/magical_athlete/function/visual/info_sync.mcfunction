$execute unless entity @e[tag=ma.table_info,scores={ct_id=$(table)}] positioned ~ ~1.79 ~ summon minecraft:text_display run function magical_athlete:visual/info_init
$execute as @e[tag=ma.table_info,scores={ct_id=$(table)}] run data modify entity @s text set from storage magical_athlete:visual info
