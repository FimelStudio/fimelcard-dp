execute unless data entity @s data.gomoku{win:[249]} run data modify entity @s data.gomoku.win append value 249
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[229]} run data modify entity @s data.gomoku.win append value 229
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[209]} run data modify entity @s data.gomoku.win append value 209
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[269]} run data modify entity @s data.gomoku.win append value 269
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[289]} run data modify entity @s data.gomoku.win append value 289
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[309]} run data modify entity @s data.gomoku.win append value 309
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[329]} run data modify entity @s data.gomoku.win append value 329
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[349]} run data modify entity @s data.gomoku.win append value 349
