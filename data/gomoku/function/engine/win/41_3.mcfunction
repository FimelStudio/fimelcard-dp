execute unless data entity @s data.gomoku{win:[41]} run data modify entity @s data.gomoku.win append value 41
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[59]} run data modify entity @s data.gomoku.win append value 59
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[77]} run data modify entity @s data.gomoku.win append value 77
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[95]} run data modify entity @s data.gomoku.win append value 95
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[23]} run data modify entity @s data.gomoku.win append value 23
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[5]} run data modify entity @s data.gomoku.win append value 5
