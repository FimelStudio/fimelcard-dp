# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
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
