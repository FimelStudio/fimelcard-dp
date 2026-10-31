execute unless data entity @s data.chess.ai.best[0] run return run function chess:ai/play
execute store result score #ai_source ch_ctx run data get entity @s data.chess.ai.best[0].f
execute unless score #ai_source ch_ctx matches 0..63 run return run function chess:ai/play
data modify entity @s data.chess.ai.current set from entity @s data.chess.ai.best[0]
data remove entity @s data.chess.ai.best[0]
data modify entity @s data.chess.ai.replies set value 0
data modify entity @s data.chess.ai.replymax set value 0
scoreboard players set @s ch_aistate 2
function chess:engine/cache
function chess:ai/apply_root
execute unless score #legal ch_ctx matches 1 run return run function chess:ai/reset
function chess:ai/build_queue
