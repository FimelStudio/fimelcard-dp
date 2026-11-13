execute unless data entity @s data.gomoku{win:[251]} run data modify entity @s data.gomoku.win append value 251
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[231]} run data modify entity @s data.gomoku.win append value 231
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[211]} run data modify entity @s data.gomoku.win append value 211
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[191]} run data modify entity @s data.gomoku.win append value 191
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[171]} run data modify entity @s data.gomoku.win append value 171
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[271]} run data modify entity @s data.gomoku.win append value 271
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[291]} run data modify entity @s data.gomoku.win append value 291
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[311]} run data modify entity @s data.gomoku.win append value 311
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[331]} run data modify entity @s data.gomoku.win append value 331
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[351]} run data modify entity @s data.gomoku.win append value 351
