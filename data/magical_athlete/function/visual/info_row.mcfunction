$data modify storage magical_athlete:visual info.extra append from entity @s data.magical_athlete.p$(side).name
$execute if score #info_actor ma_ctx matches $(side) run data modify storage magical_athlete:visual info.extra append value {text:" ▶",color:"yellow"}
data modify storage magical_athlete:visual info.extra append value {text:" · ",color:"gray"}
$data modify storage magical_athlete:visual info_player set from entity @s data.magical_athlete.p$(side)
function magical_athlete:visual/info_points with storage magical_athlete:visual info_player
execute if score @s ma_state matches 2 run data modify storage magical_athlete:visual info.extra append value {text:" · 秘密阵容",color:"gray"}
$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {index:0,side:$(side)}
$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {index:1,side:$(side)}
$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {index:2,side:$(side)}
$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {index:3,side:$(side)}
$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {index:4,side:$(side)}
$execute if score @s ma_state matches 3..5 run function magical_athlete:visual/info_racer {index:5,side:$(side)}
data modify storage magical_athlete:visual info.extra append value {text:"\n"}
