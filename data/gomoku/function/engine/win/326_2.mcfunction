execute unless data entity @s data.gomoku{win:[326]} run data modify entity @s data.gomoku.win append value 326
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[306]} run data modify entity @s data.gomoku.win append value 306
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[286]} run data modify entity @s data.gomoku.win append value 286
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[266]} run data modify entity @s data.gomoku.win append value 266
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[346]} run data modify entity @s data.gomoku.win append value 346
