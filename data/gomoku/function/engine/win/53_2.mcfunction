execute unless data entity @s data.gomoku{win:[53]} run data modify entity @s data.gomoku.win append value 53
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[33]} run data modify entity @s data.gomoku.win append value 33
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[13]} run data modify entity @s data.gomoku.win append value 13
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[73]} run data modify entity @s data.gomoku.win append value 73
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[93]} run data modify entity @s data.gomoku.win append value 93
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[113]} run data modify entity @s data.gomoku.win append value 113
