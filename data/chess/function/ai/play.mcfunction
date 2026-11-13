execute unless score @s ch_aiepoch = @s ch_epoch run return run function chess:ai/reset
execute unless score @s ch_turn = @s ch_bot run return run function chess:ai/reset
execute unless score @s ct_state matches 1 run return run function chess:ai/reset
execute unless score @s ch_state matches 1 run return run function chess:ai/reset
execute store result score #ai_source ch_ctx run data get entity @s data.chess.ai.winner.f
execute unless score #ai_source ch_ctx matches 0..63 run return run function chess:ai/no_move
function chess:game/snapshot
execute store result score #from ch_ctx run data get entity @s data.chess.ai.winner.f
execute store result score #to ch_ctx run data get entity @s data.chess.ai.winner.t
scoreboard players set #promo ch_ctx 5
function chess:engine/try_move
execute unless score #legal ch_ctx matches 1 run function chess:ai/reset
