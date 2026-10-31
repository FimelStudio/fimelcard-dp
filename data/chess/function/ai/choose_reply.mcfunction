data modify entity @s data.chess.ai.winner set from entity @s data.chess.ai.current
execute store result entity @s data.chess.ai.winner.score int 1 run scoreboard players get #ai_score ch_ctx
