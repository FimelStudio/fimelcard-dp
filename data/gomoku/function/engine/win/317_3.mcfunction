execute unless data entity @s data.gomoku{win:[317]} run data modify entity @s data.gomoku.win append value 317
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[335]} run data modify entity @s data.gomoku.win append value 335
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[353]} run data modify entity @s data.gomoku.win append value 353
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[299]} run data modify entity @s data.gomoku.win append value 299
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[281]} run data modify entity @s data.gomoku.win append value 281
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[263]} run data modify entity @s data.gomoku.win append value 263
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[245]} run data modify entity @s data.gomoku.win append value 245
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[227]} run data modify entity @s data.gomoku.win append value 227
