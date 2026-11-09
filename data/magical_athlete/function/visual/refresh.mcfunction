function magical_athlete:visual/clear
function magical_athlete:visual/context
data modify storage magical_athlete:visual track set value "mild"
execute if data entity @s data.magical_athlete{track:1} run data modify storage magical_athlete:visual track set value "wild"
function magical_athlete:visual/board_spawn with storage magical_athlete:visual
function magical_athlete:visual/dice_spawn
function magical_athlete:visual/dice_restore
execute if data entity @s data.magical_athlete.racers[0] run function magical_athlete:visual/racer_spawn {index:0}
execute if data entity @s data.magical_athlete.racers[1] run function magical_athlete:visual/racer_spawn {index:1}
execute if data entity @s data.magical_athlete.racers[2] run function magical_athlete:visual/racer_spawn {index:2}
execute if data entity @s data.magical_athlete.racers[3] run function magical_athlete:visual/racer_spawn {index:3}
execute if data entity @s data.magical_athlete.racers[4] run function magical_athlete:visual/racer_spawn {index:4}
execute if data entity @s data.magical_athlete.racers[5] run function magical_athlete:visual/racer_spawn {index:5}
# direct-v2
function magical_athlete:direct/board_refresh
