execute unless data entity @s data.gomoku{win:[38]} run data modify entity @s data.gomoku.win append value 38
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[20]} run data modify entity @s data.gomoku.win append value 20
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[2]} run data modify entity @s data.gomoku.win append value 2
