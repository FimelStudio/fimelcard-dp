execute store result score #from ch_ctx run data get entity @s data.chess.ai.queue[0].f
execute store result score #to ch_ctx run data get entity @s data.chess.ai.queue[0].t
data remove entity @s data.chess.ai.queue[0]
scoreboard players set #promo ch_ctx 5
function chess:engine/check_move
execute unless score #legal ch_ctx matches 1 run return 0
execute if score @s ch_level matches 1 run return run function chess:ai/random_legal
function chess:ai/score_move
function chess:ai/consider
