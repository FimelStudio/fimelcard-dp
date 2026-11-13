execute unless data entity @s data.gomoku{win:[340]} run data modify entity @s data.gomoku.win append value 340
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[358]} run data modify entity @s data.gomoku.win append value 358
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[322]} run data modify entity @s data.gomoku.win append value 322
