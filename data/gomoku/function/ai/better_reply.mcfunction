execute store result entity @s data.gomoku.ai.best int 1 run scoreboard players get #value gm_ctx
data modify entity @s data.gomoku.ai.chosen set from entity @s data.gomoku.ai.root_sq
