scoreboard players set @s gm_aistate 0
execute unless score @s gm_aiepoch = @s gm_epoch run return 0
execute unless score @s gm_turn = @s gm_bot run return 0
function gomoku:game/snapshot
execute store result score #to gm_ctx run data get entity @s data.gomoku.ai.chosen
function gomoku:engine/try_move
data remove entity @s data.gomoku.ai
