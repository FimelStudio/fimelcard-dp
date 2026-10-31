execute store result score #from ch_ctx run data get entity @s data.chess.ai.queue[0].f
execute store result score #to ch_ctx run data get entity @s data.chess.ai.queue[0].t
data remove entity @s data.chess.ai.queue[0]
scoreboard players set #promo ch_ctx 5
function chess:engine/check_move
execute unless score #legal ch_ctx matches 1 run return 0
execute store result score #ai_replies ch_ctx run data get entity @s data.chess.ai.replies
scoreboard players add #ai_replies ch_ctx 1
execute store result entity @s data.chess.ai.replies int 1 run scoreboard players get #ai_replies ch_ctx
function chess:ai/gain
execute store result score #ai_replymax ch_ctx run data get entity @s data.chess.ai.replymax
execute if score #ai_score ch_ctx > #ai_replymax ch_ctx store result entity @s data.chess.ai.replymax int 1 run scoreboard players get #ai_score ch_ctx
