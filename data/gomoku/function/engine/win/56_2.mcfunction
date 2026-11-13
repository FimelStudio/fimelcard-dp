execute unless data entity @s data.gomoku{win:[56]} run data modify entity @s data.gomoku.win append value 56
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[36]} run data modify entity @s data.gomoku.win append value 36
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[16]} run data modify entity @s data.gomoku.win append value 16
