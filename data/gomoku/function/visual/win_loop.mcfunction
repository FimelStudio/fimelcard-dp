data modify storage gomoku:visual sq set from storage gomoku:visual winning[0]
data remove storage gomoku:visual winning[0]
data modify storage gomoku:visual mark set value "winning"
function gomoku:visual/mark
execute if data storage gomoku:visual winning[0] run function gomoku:visual/win_loop
