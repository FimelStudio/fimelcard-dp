$data modify storage magical_athlete:visual pose set from storage magical_athlete:visual layout.pawns[$(pawn)][$(position)]
$data modify storage magical_athlete:visual next_pose set from storage magical_athlete:visual layout.pawns[$(pawn)][$(next)]
execute store result score #v_a ma_ctx run data get storage magical_athlete:visual pose.x 1000000
execute store result score #v_b ma_ctx run data get storage magical_athlete:visual next_pose.x 1000000
scoreboard players operation #v_b ma_ctx -= #v_a ma_ctx
scoreboard players operation #v_b ma_ctx *= #v_fraction ma_ctx
scoreboard players operation #v_b ma_ctx /= #v_unit ma_ctx
scoreboard players operation #v_a ma_ctx += #v_b ma_ctx
execute store result storage magical_athlete:visual pose.x double 0.000001 run scoreboard players get #v_a ma_ctx
execute store result score #v_a ma_ctx run data get storage magical_athlete:visual pose.z 1000000
execute store result score #v_b ma_ctx run data get storage magical_athlete:visual next_pose.z 1000000
scoreboard players operation #v_b ma_ctx -= #v_a ma_ctx
scoreboard players operation #v_b ma_ctx *= #v_fraction ma_ctx
scoreboard players operation #v_b ma_ctx /= #v_unit ma_ctx
scoreboard players operation #v_a ma_ctx += #v_b ma_ctx
execute store result storage magical_athlete:visual pose.z double 0.000001 run scoreboard players get #v_a ma_ctx
data modify storage magical_athlete:visual pose.duration set value 2
$execute as @e[tag=ma.racer,scores={ma_vid=$(pawn)}] if score @s ct_id = #vis_table ma_ctx run function magical_athlete:visual/racer_pose with storage magical_athlete:visual pose
