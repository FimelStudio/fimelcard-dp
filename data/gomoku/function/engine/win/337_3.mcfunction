execute unless data entity @s data.gomoku{win:[337]} run data modify entity @s data.gomoku.win append value 337
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[355]} run data modify entity @s data.gomoku.win append value 355
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[319]} run data modify entity @s data.gomoku.win append value 319
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[301]} run data modify entity @s data.gomoku.win append value 301
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[283]} run data modify entity @s data.gomoku.win append value 283
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[265]} run data modify entity @s data.gomoku.win append value 265
