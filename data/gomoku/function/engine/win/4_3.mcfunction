execute unless data entity @s data.gomoku{win:[4]} run data modify entity @s data.gomoku.win append value 4
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[22]} run data modify entity @s data.gomoku.win append value 22
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[40]} run data modify entity @s data.gomoku.win append value 40
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[58]} run data modify entity @s data.gomoku.win append value 58
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[76]} run data modify entity @s data.gomoku.win append value 76
