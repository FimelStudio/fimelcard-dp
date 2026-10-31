function gomoku:system/context
scoreboard players set #legal gm_ctx 0
execute unless score @s gm_state matches 1 run return 0
execute unless score @s ct_state matches 1 run return 0
function gomoku:engine/check_move
execute unless score #legal gm_ctx matches 1 run return 0
data modify entity @s data.gomoku.last set value {sq:0,side:1}
execute store result entity @s data.gomoku.last.sq int 1 run scoreboard players get #to gm_ctx
execute store result entity @s data.gomoku.last.side int 1 run scoreboard players get @s gm_turn
function gomoku:engine/place with entity @s data.gomoku.last
data modify entity @s data.gomoku.history append from entity @s data.gomoku.last
scoreboard players add @s gm_moves 1
scoreboard players set #minus gm_ctx -1
scoreboard players operation @s gm_turn *= #minus gm_ctx
function gomoku:game/after_move
