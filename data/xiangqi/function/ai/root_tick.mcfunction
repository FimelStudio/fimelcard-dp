execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/root_probe
execute if data entity @s data.xiangqi.ai.queue[0] run return 0
execute if score @s xq_level matches 3 run return run function xiangqi:ai/start_reply
data modify entity @s data.xiangqi.ai.winner set from entity @s data.xiangqi.ai.best[0]
return run function xiangqi:ai/play
