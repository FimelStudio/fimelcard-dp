execute unless data entity @s data.gomoku{win:[43]} run data modify entity @s data.gomoku.win append value 43
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[61]} run data modify entity @s data.gomoku.win append value 61
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[79]} run data modify entity @s data.gomoku.win append value 79
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[97]} run data modify entity @s data.gomoku.win append value 97
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[115]} run data modify entity @s data.gomoku.win append value 115
execute if score #left gm_ctx matches 5.. unless data entity @s data.gomoku{win:[133]} run data modify entity @s data.gomoku.win append value 133
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[25]} run data modify entity @s data.gomoku.win append value 25
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[7]} run data modify entity @s data.gomoku.win append value 7
