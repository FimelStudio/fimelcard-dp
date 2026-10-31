function chess:ai/apply_root
execute unless score #legal ch_ctx matches 1 run return run function chess:ai/reset
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/reply_probe
execute if data entity @s data.chess.ai.queue[0] run return 0
return run function chess:ai/finish_reply
