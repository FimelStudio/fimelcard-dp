execute unless data entity @s data.gomoku{win:[316]} run data modify entity @s data.gomoku.win append value 316
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[334]} run data modify entity @s data.gomoku.win append value 334
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[352]} run data modify entity @s data.gomoku.win append value 352
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[298]} run data modify entity @s data.gomoku.win append value 298
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[280]} run data modify entity @s data.gomoku.win append value 280
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[262]} run data modify entity @s data.gomoku.win append value 262
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[244]} run data modify entity @s data.gomoku.win append value 244
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[226]} run data modify entity @s data.gomoku.win append value 226
execute if score #right gm_ctx matches 6.. unless data entity @s data.gomoku{win:[208]} run data modify entity @s data.gomoku.win append value 208
