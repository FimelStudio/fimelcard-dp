execute store result score #ai_score xq_ctx run data get entity @s data.xiangqi.ai.current.score
execute store result score #ai_replymax xq_ctx run data get entity @s data.xiangqi.ai.replymax
scoreboard players operation #ai_score xq_ctx -= #ai_replymax xq_ctx
execute store result score #ai_replies xq_ctx run data get entity @s data.xiangqi.ai.replies
execute if score #ai_replies xq_ctx matches 0 run scoreboard players set #ai_score xq_ctx 1000000
execute store result score #ai_best xq_ctx run data get entity @s data.xiangqi.ai.winner.score
execute if score #ai_score xq_ctx > #ai_best xq_ctx run function xiangqi:ai/choose_reply
return run function xiangqi:ai/start_reply
