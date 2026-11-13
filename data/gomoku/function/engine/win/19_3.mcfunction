execute unless data entity @s data.gomoku{win:[19]} run data modify entity @s data.gomoku.win append value 19
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[1]} run data modify entity @s data.gomoku.win append value 1
