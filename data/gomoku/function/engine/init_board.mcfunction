function gomoku:system/context
scoreboard players set @e[type=minecraft:marker,tag=gm.board] gm_piece 0
scoreboard players set @s gm_turn 1
scoreboard players set @s gm_moves 0
scoreboard players set @s gm_result 0
scoreboard players set @s gm_reason 0
data modify entity @s data.gomoku.history set value []
data modify entity @s data.gomoku.win set value []
data remove entity @s data.gomoku.last
