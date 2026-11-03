$data modify storage magical_athlete:visual die_pose set from storage magical_athlete:layout dice$(die)[$(frame)]
execute as @e[tag=ma.die] if score @s ct_id = #vis_table ma_ctx run function magical_athlete:visual/die_pose with storage magical_athlete:visual die_pose
