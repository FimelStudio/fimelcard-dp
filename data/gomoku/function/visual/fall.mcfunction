execute store result storage gomoku:visual sq int 1 run scoreboard players get @s gm_sq
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/stone_pose with storage gomoku:visual
data modify entity @s data.gomoku_visual.started set value 1b
