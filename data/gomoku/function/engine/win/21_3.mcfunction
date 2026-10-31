execute unless data entity @s data.gomoku{win:[21]} run data modify entity @s data.gomoku.win append value 21
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[39]} run data modify entity @s data.gomoku.win append value 39
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[57]} run data modify entity @s data.gomoku.win append value 57
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[3]} run data modify entity @s data.gomoku.win append value 3
