scoreboard players set #ai_nine xq_ctx 9
scoreboard players operation #ai_from_rank xq_ctx = #from xq_ctx
scoreboard players operation #ai_from_rank xq_ctx /= #ai_nine xq_ctx
scoreboard players operation #ai_advance xq_ctx = #to xq_ctx
scoreboard players operation #ai_advance xq_ctx /= #ai_nine xq_ctx
scoreboard players operation #ai_advance xq_ctx -= #ai_from_rank xq_ctx
scoreboard players operation #ai_advance xq_ctx *= #side xq_ctx
scoreboard players set #ai_twenty xq_ctx 20
scoreboard players operation #ai_advance xq_ctx *= #ai_twenty xq_ctx
scoreboard players operation #ai_score xq_ctx += #ai_advance xq_ctx
