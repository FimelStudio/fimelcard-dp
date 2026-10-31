execute unless data entity @s data.gomoku{win:[15]} run data modify entity @s data.gomoku.win append value 15
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[35]} run data modify entity @s data.gomoku.win append value 35
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[55]} run data modify entity @s data.gomoku.win append value 55
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[75]} run data modify entity @s data.gomoku.win append value 75
