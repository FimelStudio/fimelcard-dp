function xiangqi:ai/apply_root
execute unless score #legal xq_ctx matches 1 run return run function xiangqi:ai/reset
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run function xiangqi:ai/reply_probe
execute if data entity @s data.xiangqi.ai.queue[0] run return 0
return run function xiangqi:ai/finish_reply
