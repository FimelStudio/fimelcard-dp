execute unless data entity @s data.gomoku{win:[30]} run data modify entity @s data.gomoku.win append value 30
execute if score #left gm_ctx matches 1.. unless data entity @s data.gomoku{win:[10]} run data modify entity @s data.gomoku.win append value 10
execute if score #right gm_ctx matches 1.. unless data entity @s data.gomoku{win:[50]} run data modify entity @s data.gomoku.win append value 50
execute if score #right gm_ctx matches 2.. unless data entity @s data.gomoku{win:[70]} run data modify entity @s data.gomoku.win append value 70
execute if score #right gm_ctx matches 3.. unless data entity @s data.gomoku{win:[90]} run data modify entity @s data.gomoku.win append value 90
execute if score #right gm_ctx matches 4.. unless data entity @s data.gomoku{win:[110]} run data modify entity @s data.gomoku.win append value 110
execute if score #right gm_ctx matches 5.. unless data entity @s data.gomoku{win:[130]} run data modify entity @s data.gomoku.win append value 130
execute if score #right gm_ctx matches 6.. unless data entity @s data.gomoku{win:[150]} run data modify entity @s data.gomoku.win append value 150
execute if score #right gm_ctx matches 7.. unless data entity @s data.gomoku{win:[170]} run data modify entity @s data.gomoku.win append value 170
