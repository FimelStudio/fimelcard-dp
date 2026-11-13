execute unless data entity @s data.gomoku{win:[112]} run data modify entity @s data.gomoku.win append value 112
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[92]} run data modify entity @s data.gomoku.win append value 92
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[72]} run data modify entity @s data.gomoku.win append value 72
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[52]} run data modify entity @s data.gomoku.win append value 52
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[32]} run data modify entity @s data.gomoku.win append value 32
execute if score #left gm_ctx matches 5.. unless data entity @s data.gomoku{win:[12]} run data modify entity @s data.gomoku.win append value 12
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[132]} run data modify entity @s data.gomoku.win append value 132
