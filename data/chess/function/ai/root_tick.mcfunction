# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
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
