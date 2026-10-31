execute unless data entity @s data.xiangqi.ai.best[0] run return run function xiangqi:ai/play
execute store result score #ai_source xq_ctx run data get entity @s data.xiangqi.ai.best[0].f
execute unless score #ai_source xq_ctx matches 0..89 run return run function xiangqi:ai/play
data modify entity @s data.xiangqi.ai.current set from entity @s data.xiangqi.ai.best[0]
data remove entity @s data.xiangqi.ai.best[0]
data modify entity @s data.xiangqi.ai.replies set value 0
data modify entity @s data.xiangqi.ai.replymax set value 0
scoreboard players set @s xq_aistate 2
function xiangqi:engine/cache
function xiangqi:ai/apply_root
execute unless score #legal xq_ctx matches 1 run return run function xiangqi:ai/reset
function xiangqi:ai/build_queue
