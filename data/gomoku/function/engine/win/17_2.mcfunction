execute unless data entity @s data.gomoku{win:[17]} run data modify entity @s data.gomoku.win append value 17
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[37]} run data modify entity @s data.gomoku.win append value 37
