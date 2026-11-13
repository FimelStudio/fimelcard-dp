execute unless data entity @s data.gomoku{win:[210]} run data modify entity @s data.gomoku.win append value 210
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[190]} run data modify entity @s data.gomoku.win append value 190
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[230]} run data modify entity @s data.gomoku.win append value 230
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[250]} run data modify entity @s data.gomoku.win append value 250
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[270]} run data modify entity @s data.gomoku.win append value 270
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[290]} run data modify entity @s data.gomoku.win append value 290
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[310]} run data modify entity @s data.gomoku.win append value 310
execute if score #right gm_ctx matches 6.. unless data entity @s data.gomoku{win:[330]} run data modify entity @s data.gomoku.win append value 330
execute if score #right gm_ctx matches 7.. unless data entity @s data.gomoku{win:[350]} run data modify entity @s data.gomoku.win append value 350
