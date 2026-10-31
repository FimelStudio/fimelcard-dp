execute unless data entity @s data.gomoku{win:[304]} run data modify entity @s data.gomoku.win append value 304
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[324]} run data modify entity @s data.gomoku.win append value 324
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[344]} run data modify entity @s data.gomoku.win append value 344
