execute unless data entity @s data.gomoku{win:[300]} run data modify entity @s data.gomoku.win append value 300
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[318]} run data modify entity @s data.gomoku.win append value 318
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[336]} run data modify entity @s data.gomoku.win append value 336
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[354]} run data modify entity @s data.gomoku.win append value 354
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[282]} run data modify entity @s data.gomoku.win append value 282
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[264]} run data modify entity @s data.gomoku.win append value 264
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[246]} run data modify entity @s data.gomoku.win append value 246
