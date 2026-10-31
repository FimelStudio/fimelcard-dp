execute store result score #from xq_ctx run data get entity @s data.xiangqi.ai.queue[0].f
execute store result score #to xq_ctx run data get entity @s data.xiangqi.ai.queue[0].t
data remove entity @s data.xiangqi.ai.queue[0]
scoreboard players set #promo xq_ctx 5
function xiangqi:engine/check_move
execute unless score #legal xq_ctx matches 1 run return 0
execute store result score #ai_replies xq_ctx run data get entity @s data.xiangqi.ai.replies
scoreboard players add #ai_replies xq_ctx 1
execute store result entity @s data.xiangqi.ai.replies int 1 run scoreboard players get #ai_replies xq_ctx
function xiangqi:ai/gain
execute store result score #ai_replymax xq_ctx run data get entity @s data.xiangqi.ai.replymax
execute if score #ai_score xq_ctx > #ai_replymax xq_ctx store result entity @s data.xiangqi.ai.replymax int 1 run scoreboard players get #ai_score xq_ctx
