execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run function chess:ai/root_probe
execute if data entity @s data.chess.ai.queue[0] run return 0
execute if score @s ch_level matches 3 run return run function chess:ai/start_reply
data modify entity @s data.chess.ai.winner set from entity @s data.chess.ai.best[0]
return run function chess:ai/play
