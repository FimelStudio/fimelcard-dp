execute unless data entity @s data.gomoku{win:[37]} run data modify entity @s data.gomoku.win append value 37
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[17]} run data modify entity @s data.gomoku.win append value 17
