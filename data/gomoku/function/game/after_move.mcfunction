scoreboard players set @s gm_sel -1
scoreboard players set @s gm_draw 0
scoreboard players set @s gm_undo 0
scoreboard players set @s gm_animundo 0
data modify entity @s data.gomoku.undo set from entity @s data.gomoku.pending_undo
data remove entity @s data.gomoku.pending_undo
execute store result score #moved_side gm_ctx run data get entity @s data.gomoku.last.side
execute unless score @s gm_bot matches 0 unless score #moved_side gm_ctx = @s gm_bot run data modify entity @s data.gomoku.ai_undo set from entity @s data.gomoku.undo
function gomoku:ai/reset
scoreboard players add @s gm_epoch 1
function gomoku:visual/place
function gomoku:game/announce_move
function gomoku:engine/evaluate
scoreboard players set @s gm_state 2
scoreboard players set @s gm_timer 6
function gomoku:clock/update
function gomoku:ui/refresh
scoreboard players set #legal gm_ctx 1
