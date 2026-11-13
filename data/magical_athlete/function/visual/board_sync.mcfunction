$execute as @e[tag=ma.board,scores={ct_id=$(table)}] run function magical_athlete:visual/board_init with storage magical_athlete:visual
$execute unless entity @e[tag=ma.board,scores={ct_id=$(table)}] run function magical_athlete:visual/board_spawn with storage magical_athlete:visual
