execute unless data entity @s data.gomoku{win:[284]} run data modify entity @s data.gomoku.win append value 284
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[302]} run data modify entity @s data.gomoku.win append value 302
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[320]} run data modify entity @s data.gomoku.win append value 320
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[338]} run data modify entity @s data.gomoku.win append value 338
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[356]} run data modify entity @s data.gomoku.win append value 356
