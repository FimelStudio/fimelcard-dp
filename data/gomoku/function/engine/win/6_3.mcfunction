execute unless data entity @s data.gomoku{win:[6]} run data modify entity @s data.gomoku.win append value 6
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[24]} run data modify entity @s data.gomoku.win append value 24
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[42]} run data modify entity @s data.gomoku.win append value 42
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[60]} run data modify entity @s data.gomoku.win append value 60
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[78]} run data modify entity @s data.gomoku.win append value 78
execute if score #left gm_ctx matches 5.. unless data entity @s data.gomoku{win:[96]} run data modify entity @s data.gomoku.win append value 96
execute if score #left gm_ctx matches 6.. unless data entity @s data.gomoku{win:[114]} run data modify entity @s data.gomoku.win append value 114
