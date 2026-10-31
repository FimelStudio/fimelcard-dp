execute unless data entity @s data.gomoku{win:[345]} run data modify entity @s data.gomoku.win append value 345
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[325]} run data modify entity @s data.gomoku.win append value 325
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[305]} run data modify entity @s data.gomoku.win append value 305
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[285]} run data modify entity @s data.gomoku.win append value 285
