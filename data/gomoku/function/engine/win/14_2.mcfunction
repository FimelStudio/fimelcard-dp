execute unless data entity @s data.gomoku{win:[14]} run data modify entity @s data.gomoku.win append value 14
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[34]} run data modify entity @s data.gomoku.win append value 34
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[54]} run data modify entity @s data.gomoku.win append value 54
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[74]} run data modify entity @s data.gomoku.win append value 74
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[94]} run data modify entity @s data.gomoku.win append value 94
