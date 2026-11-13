data modify entity @s data.xiangqi.ai.winner set from entity @s data.xiangqi.ai.current
execute store result entity @s data.xiangqi.ai.winner.score int 1 run scoreboard players get #ai_score xq_ctx
