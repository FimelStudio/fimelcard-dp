execute store result score #ai_score ch_ctx run data get entity @s data.chess.ai.current.score
execute store result score #ai_replymax ch_ctx run data get entity @s data.chess.ai.replymax
scoreboard players operation #ai_score ch_ctx -= #ai_replymax ch_ctx
execute store result score #ai_replies ch_ctx run data get entity @s data.chess.ai.replies
execute if score #ai_replies ch_ctx matches 0 if score #ai_checked ch_ctx matches 1 run scoreboard players set #ai_score ch_ctx 1000000
execute if score #ai_replies ch_ctx matches 0 if score #ai_checked ch_ctx matches 0 run scoreboard players set #ai_score ch_ctx 0
execute store result score #ai_best ch_ctx run data get entity @s data.chess.ai.winner.score
execute if score #ai_score ch_ctx > #ai_best ch_ctx run function chess:ai/choose_reply
return run function chess:ai/start_reply
