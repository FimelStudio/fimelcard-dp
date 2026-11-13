execute unless data entity @s data.gomoku{win:[339]} run data modify entity @s data.gomoku.win append value 339
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[357]} run data modify entity @s data.gomoku.win append value 357
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[321]} run data modify entity @s data.gomoku.win append value 321
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[303]} run data modify entity @s data.gomoku.win append value 303
