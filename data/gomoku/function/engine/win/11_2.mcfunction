execute unless data entity @s data.gomoku{win:[11]} run data modify entity @s data.gomoku.win append value 11
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[31]} run data modify entity @s data.gomoku.win append value 31
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[51]} run data modify entity @s data.gomoku.win append value 51
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[71]} run data modify entity @s data.gomoku.win append value 71
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[91]} run data modify entity @s data.gomoku.win append value 91
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[111]} run data modify entity @s data.gomoku.win append value 111
execute if score #right gm_ctx matches 6.. unless data entity @s data.gomoku{win:[131]} run data modify entity @s data.gomoku.win append value 131
execute if score #right gm_ctx matches 7.. unless data entity @s data.gomoku{win:[151]} run data modify entity @s data.gomoku.win append value 151
