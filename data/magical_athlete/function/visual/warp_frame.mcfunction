$data modify storage magical_athlete:visual position set value $(to)
$data modify storage magical_athlete:visual pawn set value $(pawn)
execute if score @s ma_vframe matches 6 run function magical_athlete:visual/move_to with storage magical_athlete:visual
execute if score @s ma_speed matches 1 if score @s ma_vframe matches 3 run function magical_athlete:visual/move_to with storage magical_athlete:visual
