$data modify storage magical_athlete:visual pose set from storage magical_athlete:visual layout.pawns[$(pawn)][$(position)]
data modify storage magical_athlete:visual pose.duration set value 1
$execute as @e[tag=ma.racer,scores={ma_vid=$(pawn)}] if score @s ct_id = #vis_table ma_ctx run function magical_athlete:visual/racer_pose with storage magical_athlete:visual pose
