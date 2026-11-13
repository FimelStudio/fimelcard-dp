execute unless data entity @s data.gomoku{win:[148]} run data modify entity @s data.gomoku.win append value 148
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[128]} run data modify entity @s data.gomoku.win append value 128
execute if score #left gm_ctx matches 2.. unless data entity @s data.gomoku{win:[108]} run data modify entity @s data.gomoku.win append value 108
execute if score #left gm_ctx matches 3.. unless data entity @s data.gomoku{win:[88]} run data modify entity @s data.gomoku.win append value 88
execute if score #left gm_ctx matches 4.. unless data entity @s data.gomoku{win:[68]} run data modify entity @s data.gomoku.win append value 68
execute if score #left gm_ctx matches 5.. unless data entity @s data.gomoku{win:[48]} run data modify entity @s data.gomoku.win append value 48
execute if score #left gm_ctx matches 6.. unless data entity @s data.gomoku{win:[28]} run data modify entity @s data.gomoku.win append value 28
execute if score #left gm_ctx matches 7.. unless data entity @s data.gomoku{win:[8]} run data modify entity @s data.gomoku.win append value 8
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[168]} run data modify entity @s data.gomoku.win append value 168
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[188]} run data modify entity @s data.gomoku.win append value 188
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[208]} run data modify entity @s data.gomoku.win append value 208
